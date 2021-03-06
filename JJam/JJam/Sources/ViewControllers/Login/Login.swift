//
//  Login.swift
//  JJam
//
//  Created by admin on 2017. 7. 18..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

final class Login: UIViewController {
    //MARK: Properties
    fileprivate var didSetupConstraints = false
    
    // MARK: UI
    fileprivate let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    fileprivate let usernameTextField = UITextField()
    fileprivate let passwordTextField = UITextField()
    fileprivate let loginButton = UIButton()
    fileprivate let signUpButton = UIButton()
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "로그인"
        
        self.navigationController?.navigationBar.barTintColor = .orange
        //cancelButton
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "뒤로",
            style: .done,
            target: self,
            action: #selector(cancelButtonDidTap)
        )
        self.navigationItem.leftBarButtonItem?.tintColor = .white

        UICommonSetLoading(self.activityIndicatorView)

        UICommonSetTextFieldEnable(self.usernameTextField, placeholderText: "사용자 ID")
        self.usernameTextField.addTarget(self, action: #selector(textFieldDidChangeText), for: .editingChanged)
        self.usernameTextField.delegate = self
        
        UICommonSetTextFieldEnable(self.passwordTextField, placeholderText: "패스워드")
        self.passwordTextField.isSecureTextEntry = true
        self.passwordTextField.addTarget(self, action: #selector(textFieldDidChangeText), for: .editingChanged)
        self.passwordTextField.delegate = self
        
        UICommonSetButton(self.loginButton, setTitleText: "로그인", color: 0)
        self.loginButton.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        
        UICommonSetButton(self.signUpButton, setTitleText: "회원 가입", color: 2)
        self.signUpButton.addTarget(self, action: #selector(signUpButtonDidTap), for: .touchUpInside)

        self.view.addSubview(self.usernameTextField)
        self.view.addSubview(self.passwordTextField)
        self.view.addSubview(self.loginButton)
        self.view.addSubview(self.signUpButton)
        self.view.addSubview(self.activityIndicatorView)
        
        //updateViewConstraints 자동 호출
        self.view.setNeedsUpdateConstraints()
    }
    
    //키보드 처리
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.usernameTextField.becomeFirstResponder()
    }

    
    //MARK: 애플 추천 방식으로 한번만 화면을 그리도록 한다.
    //setNeedsUpdateConstraints() 필요
    override func updateViewConstraints() {
        if !self.didSetupConstraints {
            self.didSetupConstraints = true
            self.activityIndicatorView.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            self.usernameTextField.snp.makeConstraints { make in
                make.left.equalTo(Metric.commonMid)
                make.right.equalTo(-Metric.commonMid)
                make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(Metric.commonOffset)
                make.height.equalTo(Metric.commonHeight)
            }
            self.passwordTextField.snp.makeConstraints { make in
                make.top.equalTo(self.usernameTextField.snp.bottom).offset(Metric.commonOffset)
                make.left.right.height.equalTo(self.usernameTextField)
            }
            self.loginButton.snp.makeConstraints { make in
                make.top.equalTo(self.passwordTextField.snp.bottom).offset(Metric.buttonOffset)
                make.left.right.equalTo(self.usernameTextField)
                make.height.equalTo(Metric.buttonHeight)
            }
            self.signUpButton.snp.makeConstraints { make in
                make.top.equalTo(self.loginButton.snp.bottom).offset(Metric.commonOffset)
                make.left.right.equalTo(self.usernameTextField)
                make.height.equalTo(Metric.buttonHeight)
            }
        }
        super.updateViewConstraints()
    }
    
    fileprivate struct Metric {
        static let commonMid = CGFloat(15)
        static let commonHeight = CGFloat(45)

        static let buttonHeight = CGFloat(60)

        static let commonOffset = CGFloat(15)
        static let buttonOffset = CGFloat(80)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    // cancel
    func cancelButtonDidTap() {
        AppDelegate.instance?.GeneralUsersTabBarScreen(selectIndex: 2)
    }
    
    func textFieldDidChangeText(_ textField: UITextField) {
        textField.textColor = .black
    }
    
    //UICommonSetShakeTextField() 다른 포커스에서 넘어오면 Shake 위치 오류가 있어 포커스를 먼저 이동 후 delay 가 필요함
    //UICommonSetShakeTextField() 내 포커스이동 처리는 유지함
    func loginButtonDidTap() {
        if let username = self.usernameTextField.text, username.isEmpty {
            self.usernameTextField.becomeFirstResponder()
        } else if let password = self.passwordTextField.text, password.isEmpty {
            self.passwordTextField.becomeFirstResponder()
        }
        
        let delay = 0.1 // time in seconds
        Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(loginValidation), userInfo: nil, repeats: false)
    }
    
    //로그인
    func loginValidation() {
        guard let username = self.usernameTextField.text, !username.isEmpty else {
            UICommonSetShakeTextField(self.usernameTextField)
            return
        }
        guard let password = self.passwordTextField.text, !password.isEmpty else {
            UICommonSetShakeTextField(self.passwordTextField)
            return
        }
        //로그인 Nerworking
        restaurantLogin()
    }
    
    //로그인
    func restaurantLogin() {
        UICommonSetLoadingService(self.activityIndicatorView, service: true)
        LoginNetWorking.restaurantLogin(id: self.usernameTextField.text!, password: self.passwordTextField.text!) { [weak self] response in
            guard let `self` = self else { return }
            if response.count > 0 {
                UICommonSetLoadingService(self.activityIndicatorView, service: false)
                //로그인
                let restaurant_Id = response[0].restaurant_Id
                if restaurant_Id != nil {
                    AppDelegate.instance?.BusinessUsersTabBarScreen(restaurant_Id: restaurant_Id!, selectIndex: 0)
                } else {
                    let message = response[0].message
                    if message != nil {
                        let alertController = UIAlertController(
                            title: "로그인",
                            message: message,
                            preferredStyle: .alert
                        )
                        let alertConfirm = UIAlertAction(
                            title: "확인",
                            style: .default) { _ in
                                // 확인 후 작업
                                if message == "패스워드가 잘못되었습니다." {
                                    self.passwordTextField.becomeFirstResponder()
                                } else if message == "존재하는 않는 사용자ID 입니다." {
                                    self.usernameTextField.becomeFirstResponder()
                                }
                        }
                        alertController.addAction(alertConfirm)
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    //회원 가입
    func signUpButtonDidTap() {
        let businessUsersSignUp = BusinessUsersSignUp(restaurant_Id: "")
        self.navigationController?.pushViewController(businessUsersSignUp, animated: true)
    }
}

extension Login: UITextFieldDelegate {
    //TextField 리턴키 처리
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        //loginButtonDidTap()
        return true
    }
}

