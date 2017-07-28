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
    fileprivate var EditSignUp: [SignUp] = []
    fileprivate var newSignUp: [SignUp] = []
    fileprivate var localPath:URL!
    
    //MARK: Constants
    fileprivate struct Metric {
        static let imageLabelLeft = CGFloat(10)
        static let labelRight = CGFloat(-250)
        static let buttonRight = CGFloat(-250)
        
        static let imageLeft = CGFloat(130)
        static let imageRight = CGFloat(-10)
        
        static let commonOffset = CGFloat(5)
        static let commonHeight = CGFloat(30)
        static let commonHeightImageView = CGFloat(230)
    }
    
    //MARK: UI
    fileprivate let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    fileprivate let tableView = UITableView(frame: .zero, style: .plain)
    fileprivate let imageButton = UIButton()
    fileprivate let cameraButton = UIButton()
    fileprivate var imagePicker: UIImagePickerController = UIImagePickerController()
    
    //MARK: init
    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "회원 가입"

        //데이터 임시 처리
        self.EditSignUp.append(SignUp(id: "", password: "",businessNumber: "", companyName: "", address: "", contactNumber: "", representative: ""))
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
        
        imagePicker.delegate = self

        UICommonSetButton(self.imageButton, setTitleText: "사진", color: 0)
        self.imageButton.addTarget(self, action: #selector(imageButtonDidTap), for: .touchUpInside)

        UICommonSetButton(self.cameraButton, setTitleText: "촬영", color: 0)
        self.cameraButton.addTarget(self, action: #selector(cameraButtonDidTap), for: .touchUpInside)

        self.tableView.register(BusinessUsersSignUpTextCell.self, forCellReuseIdentifier: "businessUsersSignUpTextCell")
        self.tableView.register(BusinessUsersSignUpImageCell.self, forCellReuseIdentifier: "businessUsersSignUpImageCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.imageButton)
        self.view.addSubview(self.cameraButton)
        self.view.addSubview(self.activityIndicatorView)
        

        //updateViewConstraints 자동 호출
        self.view.setNeedsUpdateConstraints()
    }
    
    //MARK: 애플 추천 방식으로 한번만 화면을 그리도록 한다.
    //setNeedsUpdateConstraints() 필요
    override func updateViewConstraints() {
        if !self.didSetupConstraints {
            self.didSetupConstraints = true
            var height: CGFloat = 0
            height += Metric.commonOffset
            height += Metric.commonHeight
            //tableView
            self.tableView.snp.makeConstraints { make in
                make.top.left.right.equalToSuperview()
                make.bottom.equalTo(self.bottomLayoutGuide.snp.bottom).offset(-(height + Metric.commonOffset))
            }
            //사진 버튼
            self.imageButton.snp.makeConstraints { make in
                make.left.equalTo(10)
                make.width.equalTo(170)
                make.height.equalTo(Metric.commonHeight)
                make.top.equalTo(self.bottomLayoutGuide.snp.bottom).offset(-(height))
            }
            //촬영 버튼
            self.cameraButton.snp.makeConstraints { make in
                make.right.equalTo(-10)
                make.width.equalTo(170)
                make.height.equalTo(Metric.commonHeight)
                make.top.equalTo(self.bottomLayoutGuide.snp.bottom).offset(-(height))
            }
            self.activityIndicatorView.snp.makeConstraints { make in
                make.center.equalToSuperview()
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
    
    func addButtonDidTap() {
        //TODO :: 저장
        let index = IndexPath(row: 0, section: 0)
        let cell: BusinessUsersSignUpTextCell = self.tableView.cellForRow(at: index) as! BusinessUsersSignUpTextCell
        //cell.configure()
        
        if cell.setInputData() {
            print("signUp.id :" + BusinessUsersSignUpTextCell.signUp.id)
            self.newSignUp.removeAll()
            self.newSignUp.append(SignUp(id: BusinessUsersSignUpTextCell.signUp.id,
                                         password: BusinessUsersSignUpTextCell.signUp.password,
                                         businessNumber: BusinessUsersSignUpTextCell.signUp.businessNumber,
                                         companyName: BusinessUsersSignUpTextCell.signUp.companyName,
                                         address: BusinessUsersSignUpTextCell.signUp.address,
                                         contactNumber: BusinessUsersSignUpTextCell.signUp.contactNumber,
                                         representative: BusinessUsersSignUpTextCell.signUp.representative))
            
            restaurantSignUp()
        } else {
            let alertController = UIAlertController(
                title: self.title,
                message: "모든 정보를 입력하세요.",
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
        
        //print("data : ", data)
        //let data
        
        //print("id : ", BusinessUsersSignUpTextCell.signUp.id)
        
        
    }
    
    //회원 가입
    func restaurantSignUp() {
        self.activityIndicatorView.startAnimating()
        BusinessUsersNetWorking.restaurantSignUp(signUp: self.newSignUp, imageURL: localPath) { [weak self] response in
            guard let `self` = self else { return }
            self.activityIndicatorView.stopAnimating()
            if response.count > 0 {
                let message = response[0].message //무조건 메시지 발생함
                if message != nil {
                    let alertController = UIAlertController(
                        title: self.title,
                        message: message,
                        preferredStyle: .alert
                    )
                    let alertConfirm = UIAlertAction(
                        title: "확인",
                        style: .default) { _ in
                            if message == "회원 가입이 완료되었습니다." {
                                _ = self.navigationController?.popViewController(animated: true)
                            }
                    }
                    alertController.addAction(alertConfirm)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
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
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        //tableView[1].imageView 이미지 변경
        let image = info[UIImagePickerControllerOriginalImage]as! UIImage
        let index = IndexPath(row: 1, section: 0)
        let cell: BusinessUsersSignUpImageCell = self.tableView.cellForRow(at: index) as! BusinessUsersSignUpImageCell
        cell.configure(image: image)
        
        //이미지 파일 URL
        let imageUrl = info[UIImagePickerControllerReferenceURL] as! NSURL
        let imageName = imageUrl.lastPathComponent
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let photoURL = NSURL(fileURLWithPath: documentDirectory)
        localPath = photoURL.appendingPathComponent(imageName!)

        //아래 작업을 하지 않으면 다른 이미지를 선택(회원 가입 완료 후 )해도 변화가 없다..!!!
        let data = UIImagePNGRepresentation(image)
        do {
            try data?.write(to: localPath!, options: Data.WritingOptions.atomic)
        } catch {
            // Catch exception here and act accordingly
        }
        
        //imagePicker 닫기
        self.dismiss(animated: true, completion: nil);
    }
    
    func cameraButtonDidTap() {
        //self.tableView.reloadData()
    }

}


extension BusinessUsersSignUp: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "businessUsersSignUpTextCell", for: indexPath) as! BusinessUsersSignUpTextCell
            cell.configure(signUp: self.EditSignUp[0])
            //cell.configure()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "businessUsersSignUpImageCell", for: indexPath) as! BusinessUsersSignUpImageCell
            let image = UIImage(named: "NoImageFound.jpg")
            cell.configure(image: image!)
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

