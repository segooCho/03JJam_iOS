//
//  MealDetail.swift
//  JJam
//
//  Created by admin on 2017. 7. 17..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

final class MealDetail: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: Properties
    fileprivate var didSetupConstraints = false
    fileprivate var viewMeal: [Meal] = []
    fileprivate var saveBusinessUsersMeal: [BusinessUsersMeal] = []
    fileprivate var image: UIImage!
    fileprivate var editImage: String = ""
    fileprivate var segmentedIndexAndCode: Int = 3
    fileprivate let uniqueId = UIDevice.current.identifierForVendor!.uuidString //UUID
    
    //MARK: Constants
    fileprivate struct Metric {
        static let segmentedMid = CGFloat(20)
        static let segmentedHeight = CGFloat(45)
        
        static let editSegmentedMid = CGFloat(0)
        static let editSegmentedHeight = CGFloat(0)

        static let likeButtonTop = CGFloat(10)
        static let likeButtonLeft = CGFloat(10)
        static let likeButtonSize = CGFloat(20)
        
        static let messageLabelTop = CGFloat(10)
        static let messageLabelLeft = CGFloat(10)
        static let messageLabelRight = CGFloat(10)
        
        static let commonOffset = CGFloat(7)
        static let commonOffset4 = CGFloat(4)
    }

    //MARK: UI
    fileprivate let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    fileprivate let segmentedControl = UISegmentedControl()
    fileprivate var imagePicker: UIImagePickerController = UIImagePickerController()
    fileprivate let segmentedTitles: Array<String> = ["사진 지우기","사진첩","카메라"]
    fileprivate let tableView = UITableView(frame: .zero, style: .plain)
    //종아요
    fileprivate let likeButton = UIButton()
    fileprivate let mesaageLabel = UILabel()

    //NotificationCenter에 등록된 옵저버의 타겟 객체가 소멸
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    //MARK: init
    init(viewMeal: [Meal]) {
        self.viewMeal = viewMeal
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.title = "상세 식단"
        
        //scroll의 내부 여백 발생시 사용()
        //self.automaticallyAdjustsScrollViewInsets = false

        //cancelButton
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelButtonDidTap)
        )

        //수정(지난 식단은 제외) 또는 신규
        if controlTuple.editMode {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .save,
                target: self,
                action: #selector(saveButtonDidTap)
            )
        }
        
        UICommonSetLoading(self.activityIndicatorView)
        
        //이미지
        imagePicker.delegate = self
        UICommonSetSegmentedControl(self.segmentedControl, titles: segmentedTitles, font: 0)
        self.segmentedControl.addTarget(self, action: #selector(changeSegmentedControl), for: .valueChanged)
        self.segmentedControl.selectedSegmentIndex = self.segmentedIndexAndCode
        self.view.addSubview(self.segmentedControl)
        
        
        self.tableView.register(MealDetailImageCell.self, forCellReuseIdentifier: "mealDetailImageCell")
        self.tableView.register(MealDetailTextCell.self, forCellReuseIdentifier: "mealDetailTextCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(self.tableView)
        
        self.likeButton.setBackgroundImage(UIImage(named: "icon-like"), for: .normal)
        self.likeButton.setBackgroundImage(UIImage(named: "icon-like-selected"), for: .selected)
        self.likeButton.addTarget(self, action: #selector(likeButtonDidTap), for: .touchUpInside)
        self.view.addSubview(self.likeButton)
        self.view.addSubview(self.mesaageLabel)
        
        self.view.addSubview(self.activityIndicatorView)
        //updateViewConstraints 자동 호출
        self.view.setNeedsUpdateConstraints()
    }
    
    //MARK: 애플 추천 방식으로 한번만 화면을 그리도록 한다.
    //setNeedsUpdateConstraints() 필요
    override func updateViewConstraints() {
        if !self.didSetupConstraints {
            self.didSetupConstraints = true
            self.editImage = self.viewMeal[0].foodImage
            self.activityIndicatorView.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            if controlTuple.editMode {
                //segmented
                self.segmentedControl.snp.makeConstraints { make in
                    make.left.equalTo(Metric.segmentedMid)
                    make.right.equalTo(-Metric.segmentedMid)
                    make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(Metric.commonOffset)
                    make.height.equalTo(Metric.segmentedHeight)
                }
                
                if controlTuple.writeMode {
                    //tableView
                    self.tableView.snp.makeConstraints { make in
                        make.top.equalTo(self.segmentedControl.snp.bottom).offset(Metric.commonOffset)
                        make.left.right.bottom.equalToSuperview()
                        make.bottom.equalTo(self.bottomLayoutGuide.snp.top).offset(-Metric.commonOffset4)
                    }
                } else {
                    //tableView
                    self.tableView.snp.makeConstraints { make in
                        make.top.equalTo(self.segmentedControl.snp.bottom).offset(Metric.commonOffset)
                        make.left.right.bottom.equalToSuperview()
                        make.bottom.equalTo(self.likeButton.snp.top).offset(-Metric.commonOffset4)
                    }
                    //like 버튼
                    self.likeButton.snp.makeConstraints { make in
                        make.left.equalTo(Metric.likeButtonLeft)
                        make.width.equalTo(Metric.likeButtonSize)
                        make.bottom.equalTo(self.bottomLayoutGuide.snp.top).offset(-Metric.commonOffset4)
                        make.height.equalTo(Metric.likeButtonSize)
                    }
                    //메시지
                    self.mesaageLabel.snp.makeConstraints { make in
                        make.left.equalTo(Metric.likeButtonSize + (Metric.commonOffset*2))
                        make.width.equalTo(self.view.snp.width).offset(Metric.likeButtonSize + Metric.commonOffset)
                        make.bottom.equalTo(self.bottomLayoutGuide.snp.top).offset(-Metric.commonOffset4)
                        make.height.equalTo(Metric.likeButtonSize)
                    }
                }

            } else {
                //tableView
                self.tableView.snp.makeConstraints { make in
                    make.top.equalTo(self.topLayoutGuide.snp.bottom)
                    make.left.right.bottom.equalToSuperview()
                    make.bottom.equalTo(self.likeButton.snp.top).offset(-Metric.commonOffset4)
                }
                //like 버튼
                self.likeButton.snp.makeConstraints { make in
                    make.left.equalTo(Metric.likeButtonLeft)
                    make.width.equalTo(Metric.likeButtonSize)
                    make.bottom.equalTo(self.bottomLayoutGuide.snp.top).offset(-Metric.commonOffset4)
                    make.height.equalTo(Metric.likeButtonSize)
                }
                //메시지
                self.mesaageLabel.snp.makeConstraints { make in
                    make.left.equalTo(Metric.likeButtonSize + (Metric.commonOffset*2))
                    make.width.equalTo(self.view.snp.width).offset(Metric.likeButtonSize + Metric.commonOffset)
                    make.bottom.equalTo(self.bottomLayoutGuide.snp.top).offset(-Metric.commonOffset4)
                    make.height.equalTo(Metric.likeButtonSize)
                }
            }
        }
        
        //좋아요 가져오기
        if !controlTuple.writeMode {
            mealLikeCountNetWorking()
        }
        
        //키보드에 숨겨지는 입력처리
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillChangeFrame),
            name: .UIKeyboardWillChangeFrame,
            object: nil
        )

        super.updateViewConstraints()
    }
    
    // MARK: Notification
    func keyboardWillChangeFrame(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect,
            let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval
            else { return }
        let keyboardVisibleHeight = UIScreen.main.bounds.height - keyboardFrame.origin.y
        UIView.animate(withDuration: duration) {
            self.tableView.contentInset.bottom = keyboardVisibleHeight
            self.tableView.scrollIndicatorInsets.bottom = keyboardVisibleHeight
            
            // 키보드가 보여지는 경우 메시지 셀로 스크롤
            if keyboardVisibleHeight > 0 {
                let indexPath = IndexPath(row: 1, section: 0) //메시지 셀
                self.tableView.scrollToRow(at: indexPath, at: .none, animated: false)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: ACTION
    func cancelButtonDidTap() {
        //NavigationController popViewController
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    /*********************************************  저장 처리 ******************************************************/
    func saveButtonDidTap() {
        // TableView[0] 에서 입력 값 가지고 오기
        // UI는 직접 처리 불가, struct만 접근 가능 제약이 많음... 병맛으로 처리 했음
        // contentView 에서는 self.present 처리도 불가능
        let index = IndexPath(row: 1, section: 0)
        let cell: MealDetailTextCell = self.tableView.cellForRow(at: index) as! MealDetailTextCell
        
        //struct tableViewCellSignUp 값 저장
        let message = cell.setInputData()
        if message.isEmpty {
            //신규 저장
            var writeMode:String = ""
            if controlTuple.writeMode {
                writeMode = "새로운 식단을 저장하시겠습니까?"
            } else {
                writeMode = "변경된 식단을 저장하시겠습니까?"
            }
            
            let alertController = UIAlertController(
                title: "식단",
                message: writeMode,
                preferredStyle: .alert
            )
            let alertCancel = UIAlertAction(
                title: "취소",
                style: .default) { _ in
                    // 확인 후 작업
                    return
            }
            let alertConfirm = UIAlertAction(
                title: "저장",
                style: .default) { _ in
                    // 확인 후 작업
                    self.mealSave()
            }
            alertController.addAction(alertCancel)
            alertController.addAction(alertConfirm)
            self.present(alertController, animated: true, completion: nil)
        } else {
            //TODO : 입력값 처리
            let alertController = UIAlertController(
                title: self.title,
                message: message,
                preferredStyle: .alert
            )
            let alertConfirm = UIAlertAction(
                title: "확인",
                style: .default) { _ in
                    // 확인 후 작업
            }
            alertController.addAction(alertConfirm)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func mealSave() {
        self.saveBusinessUsersMeal.removeAll()
        self.saveBusinessUsersMeal = MealDetailTextCell.tableViewCellMeal.businessUsersMeal
        if saveBusinessUsersMeal.count < 0 {
            let alertController = UIAlertController(
                title: self.title,
                message: "식단 등록 처리 중 오류가 발생했습니다.",
                preferredStyle: .alert
            )
            let alertConfirm = UIAlertAction(
                title: "확인",
                style: .default) { _ in
                    // 확인 후 작업
            }
            alertController.addAction(alertConfirm)
            self.present(alertController, animated: true, completion: nil)
            return
        } else {
            //print(self.viewMeal[0].meal_Id)
            //print(self.viewMeal[0].restaurant_Id)
            mealSaveNetWorking()
        }
    }
    
    func mealSaveNetWorking() {
        let Oid: String
        if controlTuple.writeMode {
            Oid = self.viewMeal[0].restaurant_Id
        } else {
            Oid = self.viewMeal[0].meal_Id
        }
        
        UICommonSetLoadingService(self.activityIndicatorView, service: true)
        BusinessUsersNetWorking.restaurantMealEditAndWrite(
            Oid: Oid,
            businessUsersMeal: self.saveBusinessUsersMeal,
            image: image,
            editImage: self.editImage) { [weak self] response in
                guard let `self` = self else { return }
                if response.count > 0 {
                    //Notification 포함 작동 중
                    UICommonSetLoadingService(self.activityIndicatorView, service: false)
                    let message = response[0].message //무조건 리턴 메시지 발생함
                    if message != nil {
                        if message == "식단 저장이 완료되었습니다." || message == "식단 수정이 완료되었습니다." {
                            //OK
                            let alertController = UIAlertController(
                                title: self.title,
                                message: message,
                                preferredStyle: .alert
                            )
                            let alertLoginScreen = UIAlertAction(
                                title: "이전 페이지 이동",
                                style: .default) { _ in
                                    //이전 페이지
                                    _ = self.navigationController?.popViewController(animated: true)
                            }
                            alertController.addAction(alertLoginScreen)
                            
                            //신규 저장 후 이전 페이지로 가지 않고 바로 저장하면 오류 발생
                            //Notification 발생으로 mealDetailTuple.writeMode=false로 변경됨
                            /*
                             if !mealDetailTuple.writeMode {
                             let alertConfirm = UIAlertAction(
                             title: "확인",
                             style: .default) { _ in
                             //확인 후 처리
                             }
                             alertController.addAction(alertConfirm)
                             }
                             */
                            
                            //에디터 모드 일때 이전 페이지 data reload 처리
                            if controlTuple.editMode {
                                NotificationCenter.default.post(name: .businessUsersMealListDidAdd, object: self, userInfo: [:])
                            }
                            UICommonSetLoadingService(self.activityIndicatorView, service: false)
                            self.present(alertController, animated: true, completion: nil)
                            
                        } else {
                            //Error 메시지
                            let alertController = UIAlertController(
                                title: self.title,
                                message: message,
                                preferredStyle: .alert
                            )
                            let alertConfirm = UIAlertAction(
                                title: "확인",
                                style: .default) { _ in
                                    //확인 후 처리
                            }
                            alertController.addAction(alertConfirm)
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                }
        }
    }
    
    /*********************************************  맛있어요 처리 ******************************************************/
    func mealLikeCountNetWorking() {
        UICommonSetLoadingService(self.activityIndicatorView, service: true)
        CommonNetWorking.mealLikeCount(
            meal_Id: self.viewMeal[0].meal_Id,
            uniqueId: self.uniqueId
            ) { [weak self] response in
                guard let `self` = self else { return }
                UICommonSetLoadingService(self.activityIndicatorView, service: false)
                if response.count > 0 {
                    //Notification 포함 작동 중
                    let check = response[0].check   //무조건 리턴 발생함
                    let cnt = response[0].cnt       //무조건 리턴 발생함
                    
                    //check
                    if check == "y" {
                        self.likeButton.isSelected = true
                    } else {
                        self.likeButton.isSelected = false
                    }
                    //like
                    self.mesaageLabel.text = self.likeCountLabelText(likeCount: cnt!)
                }
        }
    }

    func mealLikeNetWorking() {
        UICommonSetLoadingService(self.activityIndicatorView, service: true)
        CommonNetWorking.mealLike(
            meal_Id: self.viewMeal[0].meal_Id,
            uniqueId: uniqueId
        ) { [weak self] response in
            guard let `self` = self else { return }
            if response.count > 0 {
                UICommonSetLoadingService(self.activityIndicatorView, service: false)
                let message = response[0].message   //무조건 리턴 메시지 발생함
                if message != nil {
                    if message == "맛있어요 설정되었습니다." || message == "맛있어요 해제되었습니다." {
                        self.mealLikeCountNetWorking()
                    } else {
                        //Error 메시지
                        let alertController = UIAlertController(
                            title: self.title,
                            message: message,
                            preferredStyle: .alert
                        )
                        let alertConfirm = UIAlertAction(
                            title: "확인",
                            style: .default) { _ in
                                //확인 후 처리
                        }
                        alertController.addAction(alertConfirm)
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    func likeButtonDidTap() {
        mealLikeNetWorking()
    }
    
    func likeCountLabelText(likeCount: Int) -> String {
        if likeCount == 0 {
            return "가장 먼저 맛있어요를 눌러보세요."
        } else {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            return "\(numberFormatter.string(from: NSNumber(value:likeCount))!)명이 맛있어요 했습니다."
        }
    }
    
    /*********************************************  이미지 처리 ******************************************************/
    func changeSegmentedControl() {
        self.segmentedIndexAndCode = segmentedControl.selectedSegmentIndex
        switch self.segmentedControl.selectedSegmentIndex {
        case 1:     //사진첩
            imageButtonDidTap()
        case 2:     //카메라
            cameraButtonDidTap()
        case 3:     //세그먼트 버튼 선택이 없는 상태 초기
            break
        default:    //지우기
            noImageButtonDidTap()
        }
    }
    
    func imageButtonDidTap() {
        //photoLibrary
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary)){
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Photo Library Not Found", message: "This device has no Photo Library", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
            self.segmentedControl.selectedSegmentIndex = 0
            self.segmentedIndexAndCode = 0
            noImageButtonDidTap()
        }
    }
    
    func cameraButtonDidTap() {
        //camera
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            present(imagePicker, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
            self.segmentedControl.selectedSegmentIndex = 0
            self.segmentedIndexAndCode = 0
            noImageButtonDidTap()
        }
    }
    
    func noImageButtonDidTap() {
        image = nil
        self.editImage = "NoImageFound.jpg"
        //지정된 row만 reload 한다.(전체 로드시 입력 값이 지워짐)
        let index = IndexPath(row: 0, section: 0)
        self.tableView.reloadRows(at: [index], with: .none)
        //self.tableView.reloadData()
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        //스크롤을 최상단으로 올린다.
        //=> imageView가 안보이는 상태에서 cellForRow 에서 오류가 발생
        self.tableView.setContentOffset(CGPoint.zero, animated: true)
        
        //tableView[1].imageView 이미지 변경
        self.image = setImageSize(info[UIImagePickerControllerOriginalImage]as! UIImage, size: 1)
        let index = IndexPath(row: 0, section: 0)
        let cell: MealDetailImageCell = self.tableView.cellForRow(at: index) as! MealDetailImageCell
        cell.configure(image: self.image!)
        
        //imagePicker 닫기
        self.dismiss(animated: true, completion: nil);
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //imagePicker 닫기
        self.dismiss(animated: true, completion: nil);

        let alert = UIAlertController(title: "확인", message: "사진 정보가 초기화되었습니다.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
        self.segmentedControl.selectedSegmentIndex = 0
        self.segmentedIndexAndCode = 0
        noImageButtonDidTap()
    }

}


extension MealDetail: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "mealDetailImageCell", for: indexPath) as! MealDetailImageCell
            
            if !controlTuple.editMode {
                cell.configure(editImage: self.viewMeal[0].foodImage!)
            } else if image != nil {
                cell.configure(image: self.image!)
            } else {
                cell.configure(editImage: self.editImage)
            }
            
            //cell.configure(foodImage: self.viewMeal[0].foodImage!)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "mealDetailTextCell", for: indexPath) as! MealDetailTextCell
            cell.configure(meal: self.viewMeal[0])
            return cell
        }
    }
}

extension MealDetail: UITableViewDelegate {
    //cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return MealDetailImageCell.height(width: tableView.frame.width)
        } else {
            return MealDetailTextCell.height()
        }
    }
}
