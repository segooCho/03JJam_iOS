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
    fileprivate var didSetupConstraints = false
    var segmentedIndexAndCode: Int = 0

    fileprivate var editSignUp: [SignUp] = []
    fileprivate var newSignUp: [SignUp] = []
    fileprivate var image:UIImage!
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
    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "회원 가입"

        //데이터 임시 처리
        self.editSignUp.append(SignUp(id: "", password: "",businessNumber: "", companyName: "", address: "", contactNumber: "", representative: ""))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelButtonDidTap)
        )
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonDidTap)
        )
        
        UICommonSetLoading(uiKit: self.activityIndicatorView)
        
        self.tableView.register(BusinessUsersSignUpTextCell.self, forCellReuseIdentifier: "businessUsersSignUpTextCell")
        self.tableView.register(BusinessUsersSignUpImageCell.self, forCellReuseIdentifier: "businessUsersSignUpImageCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        //segmentedControl
        imagePicker.delegate = self
        UICommonSetSegmentedControl(self.segmentedControl, titles: segmentedTitles)
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
                make.top.left.right.equalToSuperview()
                make.bottom.equalTo(self.bottomLayoutGuide.snp.bottom).offset(-(height + Metric.commonOffset))
            }
            
            //segmented
            self.segmentedControl.snp.makeConstraints { make in
                make.left.equalTo(Metric.segmentedMid)
                make.right.equalTo(-Metric.segmentedMid)
                make.top.equalTo(self.bottomLayoutGuide.snp.bottom).offset(-(height))
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
                self.newSignUp.removeAll()
                self.newSignUp.append(SignUp(id: BusinessUsersSignUpTextCell.signUp.id,
                                             password: BusinessUsersSignUpTextCell.signUp.password,
                                             businessNumber: BusinessUsersSignUpTextCell.signUp.businessNumber,
                                             companyName: BusinessUsersSignUpTextCell.signUp.companyName,
                                             address: BusinessUsersSignUpTextCell.signUp.address,
                                             contactNumber: BusinessUsersSignUpTextCell.signUp.contactNumber,
                                             representative: BusinessUsersSignUpTextCell.signUp.representative))
                
                self.restaurantSignUpNetWorking()
        }
        alertController.addAction(alertCancel)
        alertController.addAction(alertConfirm)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //회원 가입
    func restaurantSignUpNetWorking() {
        UICommonSetLoadingService(self.activityIndicatorView, service: true)
        BusinessUsersNetWorking.restaurantSignUp(signUp: self.newSignUp, image: image) { [weak self] response in
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
                        let alertConfirm = UIAlertAction(
                            title: "확인",
                            style: .default) { _ in
                                //확인 후 처리
                        }
                        alertController.addAction(alertLoginScreen)
                        alertController.addAction(alertConfirm)
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
        let index = IndexPath(row: 1, section: 0)
        let cell = tableView.dequeueReusableCell(withIdentifier: "businessUsersSignUpImageCell", for: index) as! BusinessUsersSignUpImageCell
        let noImage = UIImage(named: "NoImageFound.jpg")
        cell.configure(image: noImage!)
        self.tableView.reloadData()
    }
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        //tableView[1].imageView 이미지 변경
        self.image = info[UIImagePickerControllerOriginalImage]as! UIImage
        let index = IndexPath(row: 1, section: 0)
        let cell: BusinessUsersSignUpImageCell = self.tableView.cellForRow(at: index) as! BusinessUsersSignUpImageCell
        cell.configure(image: self.image!)

        //imagePicker 닫기
        self.dismiss(animated: true, completion: nil);
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //imagePicker 닫기
        self.dismiss(animated: true, completion: nil);
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
            cell.configure(signUp: self.editSignUp[0])
            //cell.configure()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "businessUsersSignUpImageCell", for: indexPath) as! BusinessUsersSignUpImageCell
            
            //TableView 스크롤로 새로운 이지미지가 덮어진다.
            if self.segmentedIndexAndCode == 0 {
                let noImage = UIImage(named: "NoImageFound.jpg")
                cell.configure(image: noImage!)
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

extension BusinessUsersSignUp: UITextFieldDelegate {
    //TextField 리턴키 처리
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

