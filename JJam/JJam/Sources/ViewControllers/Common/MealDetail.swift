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
    fileprivate var editBusinessUsersMeal: [BusinessUsersMeal] = []
    fileprivate var image: UIImage!
    fileprivate var editImage: String = ""
    fileprivate var segmentedIndexAndCode: Int = 3

    //MARK: Constants
    fileprivate struct Metric {
        static let segmentedMid = CGFloat(20)
        static let segmentedHeight = CGFloat(45)

        static let commonOffset = CGFloat(7)
    }

    //MARK: UI
    fileprivate let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    fileprivate let segmentedControl = UISegmentedControl()
    fileprivate var imagePicker: UIImagePickerController = UIImagePickerController()
    fileprivate let segmentedTitles: Array<String> = ["사진 지우기","사진첩","카메라"]
    fileprivate let tableView = UITableView(frame: .zero, style: .plain)

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
        
        //cancelButton
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelButtonDidTap)
        )

        //수정(지난 식단은 제외) 또는 신규
        if mealDetailTuple.editMode {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .save,
                target: self,
                action: #selector(saveButtonDidTap)
            )
        }
        
        UICommonSetLoading(self.activityIndicatorView)
        
        //이미지
        imagePicker.delegate = self
        UICommonSetSegmentedControl(self.segmentedControl, titles: segmentedTitles)
        self.segmentedControl.addTarget(self, action: #selector(changeSegmentedControl), for: .valueChanged)
        self.segmentedControl.selectedSegmentIndex = self.segmentedIndexAndCode
        //수정 모드 일때만 추가
        if mealDetailTuple.editMode {
            self.view.addSubview(self.segmentedControl)
        }
        
        self.tableView.register(MealDetailImageCell.self, forCellReuseIdentifier: "mealDetailImageCell")
        self.tableView.register(MealDetailTextCell.self, forCellReuseIdentifier: "mealDetailTextCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(self.activityIndicatorView)
        self.view.addSubview(self.tableView)
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
            if mealDetailTuple.editMode {
                //segmented
                self.segmentedControl.snp.makeConstraints { make in
                    make.left.equalTo(Metric.segmentedMid)
                    make.right.equalTo(-Metric.segmentedMid)
                    make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(Metric.commonOffset)
                    make.height.equalTo(Metric.segmentedHeight)
                }
                //tableView
                self.tableView.snp.makeConstraints { make in
                    make.top.equalTo(self.segmentedControl.snp.bottom).offset(Metric.commonOffset)
                    make.left.right.bottom.equalToSuperview()
                    make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
                }
            } else {
                //tableView
                self.tableView.snp.makeConstraints { make in
                    make.top.equalTo(self.topLayoutGuide.snp.bottom)
                    make.left.right.bottom.equalToSuperview()
                    make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
                }
            }

        }
        super.updateViewConstraints()
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
            let alertController = UIAlertController(
                title: "식단",
                message: "저장 하시겠습니까?",
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
        self.editBusinessUsersMeal.removeAll()
        self.editBusinessUsersMeal = MealDetailTextCell.tableViewCellMeal.businessUsersMeal
        if editBusinessUsersMeal.count < 0 {
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
            print(self.viewMeal[0]._id)
            print(self.viewMeal[0].restaurant_Id)
            mealSaveNetWorking()
        }
    }
    
    func mealSaveNetWorking() {
        let id: String
        if mealDetailTuple.writeMode {
            id = self.viewMeal[0].restaurant_Id
        } else {
            id = self.viewMeal[0]._id
        }
        
        UICommonSetLoadingService(self.activityIndicatorView, service: true)
        BusinessUsersNetWorking.restaurantMeal(id: id,
                                               businessUsersMeal: self.editBusinessUsersMeal,
                                               image: image,
                                               editImage: self.editImage) { [weak self] response in
            guard let `self` = self else { return }
            if response.count > 0 {
                //Notification 포함 작동 중
                UICommonSetLoadingService(self.activityIndicatorView, service: false)
                let message = response[0].message //무조건 리턴 메시지 발생함
                if message != nil {
                    if message == "식단 저장이 완료되었습니다." {
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
                        let alertConfirm = UIAlertAction(
                            title: "확인",
                            style: .default) { _ in
                                //확인 후 처리
                        }
                        alertController.addAction(alertLoginScreen)
                        alertController.addAction(alertConfirm)
                        //에디터 모드 일때 이전 페이지 data reload 처리
                        if mealDetailTuple.editMode {
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
        //let index = IndexPath(row: 0, section: 0)
        //let cell = tableView.dequeueReusableCell(withIdentifier: "mealDetailImageCell", for: index) as! MealDetailImageCell
        //let noImage = UIImage(named: "NoImageFound.jpg")
        //cell.configure(image: noImage!)
        self.editImage = "NoImageFound.jpg"
        self.tableView.reloadData()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        //tableView[1].imageView 이미지 변경
        self.image = info[UIImagePickerControllerOriginalImage]as! UIImage
        let index = IndexPath(row: 0, section: 0)
        let cell: MealDetailImageCell = self.tableView.cellForRow(at: index) as! MealDetailImageCell
        cell.configure(image: self.image!)
        
        //imagePicker 닫기
        self.dismiss(animated: true, completion: nil);
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //imagePicker 닫기
        self.dismiss(animated: true, completion: nil);

        let alert = UIAlertController(title: "확인", message: "이미지가 초기화되었습니다.", preferredStyle: .alert)
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
            
            
            if !mealDetailTuple.editMode {
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