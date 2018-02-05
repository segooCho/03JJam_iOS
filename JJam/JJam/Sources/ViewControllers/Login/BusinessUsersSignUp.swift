//
//  BusinessUsersSignUp.swift
//  JJam
//
//  Created by admin on 2017. 7. 20..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

final class BusinessUsersSignUp: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: Properties
    fileprivate let restaurant_Id: String
    fileprivate var didSetupConstraints = false
    fileprivate var segmentedIndexAndCode: Int = 3

    fileprivate var blankSignUp: [SignUp] = []      //공백 data : tableView.indexPath.row == 0 임시 바인딩용
    fileprivate var newSignUp: [SignUp] = []        //입력 data : tableView.indexPath.row == 0 에서 가져옴
    fileprivate var member: [Member] = []           //서버 data
    fileprivate var image: UIImage!
    fileprivate var editImage: String = ""         //서버 이미지 파일명
    //let image
    
    //MARK: Constants
    fileprivate struct Metric {
        static let segmentedMid = CGFloat(20)
        static let segmentedHeight = CGFloat(45)

        static let commonOffset = CGFloat(7)
    }
    
    //MARK: UI
    fileprivate let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    fileprivate let tableView = UITableView(frame: .zero, style: .plain)
    fileprivate var imagePicker: UIImagePickerController = UIImagePickerController()
    fileprivate let segmentedControl = UISegmentedControl()
    fileprivate let segmentedTitles: Array<String> = ["사진 지우기","사진첩","카메라"]
    
    
    //MARK: init
    init(restaurant_Id: String) {
        self.restaurant_Id = restaurant_Id
        super.init(nibName: nil, bundle: nil)

        //먼저 그리기 위해
        self.blankSignUp.append(SignUp(id: "", password: "",businessNumber: "", companyName: "", address: "", contactNumber: "", representative: ""))

        //회원 수정
        if self.restaurant_Id != "" {
            self.title = "회원 수정"
            restaurantMemberNetWorking()
        } else {
            self.title = "회원 가입"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        //scroll의 내부 여백 발생시 사용()
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationController?.navigationBar.barTintColor = .orange
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "뒤로",
            style: .done,
            target: self,
            action: #selector(cancelButtonDidTap)
        )
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "등록 하기",
            style: .done,
            target: self,
            action: #selector(addButtonDidTap)
        )
        self.navigationItem.rightBarButtonItem?.tintColor = .white

        UICommonSetLoading(self.activityIndicatorView)
        
        self.tableView.register(BusinessUsersSignUpTextCell.self, forCellReuseIdentifier: "businessUsersSignUpTextCell")
        self.tableView.register(BusinessUsersSignUpImageCell.self, forCellReuseIdentifier: "businessUsersSignUpImageCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        //segmentedControl
        imagePicker.delegate = self
        UICommonSetSegmentedControl(self.segmentedControl, titles: segmentedTitles, font: 0)
        self.segmentedControl.addTarget(self, action: #selector(changeSegmentedControl), for: .valueChanged)
        self.segmentedControl.selectedSegmentIndex = self.segmentedIndexAndCode
        
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.segmentedControl)
        self.view.addSubview(self.activityIndicatorView)
        
        //updateViewConstraints 자동 호출
        self.view.setNeedsUpdateConstraints()
    }
    
    //MARK: 애플 추천 방식으로 한번만 화면을 그리도록 한다.
    //setNeedsUpdateConstraints() 필요
    override func updateViewConstraints() {
        if !self.didSetupConstraints {
            self.didSetupConstraints = true
            self.activityIndicatorView.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            var height: CGFloat = 0
            height += Metric.commonOffset
            height += Metric.segmentedHeight
            //tableView
            self.tableView.snp.makeConstraints { make in
                make.top.equalTo(self.topLayoutGuide.snp.bottom)
                make.left.right.equalToSuperview()
                make.bottom.equalTo(self.bottomLayoutGuide.snp.top).offset(-(height+Metric.commonOffset))
            }
            //segmented
            self.segmentedControl.snp.makeConstraints { make in
                make.left.equalTo(Metric.segmentedMid)
                make.right.equalTo(-Metric.segmentedMid)
                make.top.equalTo(self.bottomLayoutGuide.snp.top).offset(-height)
                make.height.equalTo(Metric.segmentedHeight)
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
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    /*********************************************  회원 가입  ******************************************************/

    func addButtonDidTap() {
        // TableView[0] 에서 입력 값 가지고 오기
        // UI는 직접 처리 불가, struct만 접근 가능 제약이 많음... 병맛으로 처리 했음
        // contentView 에서는 self.present 처리도 불가능
        let index = IndexPath(row: 0, section: 0)
        let cell: BusinessUsersSignUpTextCell = self.tableView.cellForRow(at: index) as! BusinessUsersSignUpTextCell
        
        //struct tableViewCellSignUp 값 저장
        let message = cell.setInputData()
        if message.isEmpty {
            //print("signUp.id :" + BusinessUsersSignUpTextCell.signUp.id)
            //if self.image == nil {
            if self.segmentedIndexAndCode == 0 {
                let alertController = UIAlertController(
                    title: self.title,
                    message: "사업자 등록증 사진 정보가 없습니다.\n추후 인증 업체 자격을 획득할 수 없습니다.\n그래도 계속 진행하시겠습니까?",
                    preferredStyle: .alert
                )
                let alertCancel = UIAlertAction(
                    title: "취소",
                    style: .default) { _ in
                        // 확인 후 작업
                        return
                }
                let alertConfirm = UIAlertAction(
                    title: "계속 진행",
                    style: .default) { _ in
                        // 확인 후 작업
                        self.privacyAgree()
                }
                alertController.addAction(alertCancel)
                alertController.addAction(alertConfirm)
                self.present(alertController, animated: true, completion: nil)
            } else {
                self.privacyAgree()
            }
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
    
    //개인 정보 수집 동의 및 정보 확인
    func privacyAgree() {
        self.newSignUp.removeAll()
        //print(BusinessUsersSignUpTextCell.tableViewCellSignUp.signUp)
        self.newSignUp = BusinessUsersSignUpTextCell.tableViewCellSignUp.signUp
        if newSignUp.count < 0 {
            let alertController = UIAlertController(
                title: self.title,
                message: "회원 가입 처리 중 오류가 발생했습니다.",
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
            let alertController = UIAlertController(
                title: self.title,
                message: "입력된 회원정보 수집에 동의하십니까?\n*운영진의 재량권에 따라 수정 요청 또는 무 통보 삭제가 될 수 있습니다.",
                preferredStyle: .alert
            )
            let alertCancel = UIAlertAction(
                title: "취소",
                style: .default) { _ in
                    // 확인 후 작업
                    return
            }
            let alertConfirm = UIAlertAction(
                title: "동의",
                style: .default) { _ in
                    // 확인 후 작업
                    if self.restaurant_Id == "" {
                        self.restaurantSignUpNetWorking()
                    } else {
                        self.restaurantEditNetWorking()
                    }
            }
            alertController.addAction(alertCancel)
            alertController.addAction(alertConfirm)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    //회원 가입
    func restaurantSignUpNetWorking() {
        UICommonSetLoadingService(self.activityIndicatorView, service: true)
        LoginNetWorking.restaurantSignUp(signUp: self.newSignUp, image: image) { [weak self] response in
            guard let `self` = self else { return }
            if response.count > 0 {
                UICommonSetLoadingService(self.activityIndicatorView, service: false)
                let message = response[0].message //무조건 리턴 메시지 발생함
                if message != nil {
                    if message == "회원 가입이 완료되었습니다." {
                        //OK
                        let alertController = UIAlertController(
                            title: self.title,
                            message: message,
                            preferredStyle: .alert
                        )
                        let alertLoginScreen = UIAlertAction(
                            title: "로그인 페이지 이동",
                            style: .default) { _ in
                                //로그인 페이지
                                _ = self.navigationController?.popViewController(animated: true)
                        }
                        alertController.addAction(alertLoginScreen)
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
    
    //회원 정보 조회
    func restaurantMemberNetWorking() {
        UICommonSetLoadingService(self.activityIndicatorView, service: true)
        LoginNetWorking.restaurantMember(restaurant_Id: self.restaurant_Id) { [weak self] response in
            guard let `self` = self else { return }
            if response.count > 0 {
                UICommonSetLoadingService(self.activityIndicatorView, service: false)
                let message = response[0].message //무조건 리턴 메시지 발생함
                if message != nil {
                    if message == "회원 정보가 없습니다." {
                        //OK
                        let alertController = UIAlertController(
                            title: self.title,
                            message: message,
                            preferredStyle: .alert
                        )
                        let alertPreScreen = UIAlertAction(
                            title: "이전 페이지로 이동",
                            style: .default) { _ in
                                //로그인 페이지
                                _ = self.navigationController?.popViewController(animated: true)
                        }
                        alertController.addAction(alertPreScreen)
                        self.present(alertController, animated: true, completion: nil)
                    }
                } else {
                    //print(response[0])
                    self.blankSignUp.removeAll()
                    self.blankSignUp.append(SignUp(id: response[0].id!,
                                                   password: "",
                                                   businessNumber: response[0].businessNumber!,
                                                   companyName: response[0].companyName!,
                                                   address: response[0].address!,
                                                   contactNumber: response[0].contactNumber!,
                                                   representative: response[0].representative!))
                    
                    self.editImage = response[0].businessLicenseImage!
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    //회원 수정
    func restaurantEditNetWorking() {
        UICommonSetLoadingService(self.activityIndicatorView, service: true)
        LoginNetWorking.restaurantEdit(restaurant_Id: self.restaurant_Id, signUp: self.newSignUp, image: image, editImage: editImage) { [weak self] response in
            guard let `self` = self else { return }
            if response.count > 0 {
                UICommonSetLoadingService(self.activityIndicatorView, service: false)
                let message = response[0].message //무조건 리턴 메시지 발생함
                if message != nil {
                    if message == "회원 수정이 완료되었습니다.\n로그인 페이지로 이동합니다." {
                        //OK
                        let alertController = UIAlertController(
                            title: self.title,
                            message: message,
                            preferredStyle: .alert
                        )
                        let alertLoginScreen = UIAlertAction(
                            title: "로그인 페이지로 이동",
                            style: .default) { _ in
                                //로그인 페이지
                                AppDelegate.instance?.LoginScreen()
                                //_ = self.navigationController?.popViewController(animated: true)
                        }
                        alertController.addAction(alertLoginScreen)
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
        //self.tableView.setContentOffset(CGPoint.zero, animated: true)
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
        let index = IndexPath(row: 1, section: 0)
        self.tableView.reloadRows(at: [index], with: .none)
        //self.tableView.reloadData()
    }
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        //스크롤을 하단으로 올린다.
        //=> imageView가 안보이는 상태에서 cellForRow 에서 오류가 발생
        var yOffset:CGFloat = 0;
        yOffset = self.tableView.contentSize.height - self.tableView.bounds.size.height;
        self.tableView.setContentOffset(CGPoint.init(x: 0, y: yOffset), animated: true)
        

        //tableView[1].imageView 이미지 변경
        self.image = setImageSize(info[UIImagePickerControllerOriginalImage]as! UIImage, size: 1)
        //TODO :: cell이 보이지 않는 상태에서는 오류 발생????
        let index = IndexPath(row: 1, section: 0)
        let cell: BusinessUsersSignUpImageCell = self.tableView.cellForRow(at: index) as! BusinessUsersSignUpImageCell
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


extension BusinessUsersSignUp: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "businessUsersSignUpTextCell", for: indexPath) as! BusinessUsersSignUpTextCell
            cell.configure(signUp: self.blankSignUp[0])
            //cell.configure()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "businessUsersSignUpImageCell", for: indexPath) as! BusinessUsersSignUpImageCell
            
            //TableView 스크롤로 새로운 이지미지가 덮어진다.
            if self.segmentedIndexAndCode == 0 || self.segmentedIndexAndCode == 3 || self.image == nil {
                if editImage != "" {
                    cell.configure(editImage: editImage)
                } else {
                    let noImage = UIImage(named: "NoImageFound.jpg")
                    cell.configure(image: noImage!)
                }
            } else {
                cell.configure(image: self.image!)
            }
            return cell
        }
    }
}

extension BusinessUsersSignUp: UITableViewDelegate {
    //cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return BusinessUsersSignUpTextCell.height()
        } else {
            return BusinessUsersSignUpImageCell.height(width: tableView.frame.width)
        }
    }
}

/*
extension BusinessUsersSignUp: UITextFieldDelegate {
    //TextField 리턴키 처리
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

extension BusinessUsersSignUp: UITextViewDelegate {
    //UITextView 리턴키 처리
    func textViewShouldReturn(_ textView: UITextView) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
*/
