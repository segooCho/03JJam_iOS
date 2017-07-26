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
    var didSetupConstraints = false
    
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
        
        //cancelButton
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelButtonDidTap)
        )

        UICommonSetTextFieldEnable(self.usernameTextField, placeholderText: "사용자 ID")
        self.usernameTextField.addTarget(self, action: #selector(textFieldDidChangeText), for: .editingChanged)
        self.usernameTextField.delegate = self
        
        UICommonSetTextFieldEnable(self.passwordTextField, placeholderText: "패스워드")
        self.passwordTextField.isSecureTextEntry = true
        self.passwordTextField.addTarget(self, action: #selector(textFieldDidChangeText), for: .editingChanged)
        self.passwordTextField.delegate = self
        
        UICommonSetButton(self.loginButton, setTitleText: "로그인", colorInt: 0)
        self.loginButton.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        
        UICommonSetButton(self.signUpButton, setTitleText: "회원 가입", colorInt: 1)
        self.signUpButton.addTarget(self, action: #selector(signUpButtonDidTap), for: .touchUpInside)

        self.view.addSubview(self.usernameTextField)
        self.view.addSubview(self.passwordTextField)
        self.view.addSubview(self.loginButton)
        self.view.addSubview(self.signUpButton)
        
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
            self.usernameTextField.snp.makeConstraints { make in
                make.left.equalTo(15)
                make.right.equalTo(-15)
                make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(15)
                make.height.equalTo(30)
            }
            self.passwordTextField.snp.makeConstraints { make in
                make.top.equalTo(self.usernameTextField.snp.bottom).offset(10)
                make.left.right.height.equalTo(self.usernameTextField)
            }
            self.loginButton.snp.makeConstraints { make in
                make.top.equalTo(self.passwordTextField.snp.bottom).offset(15)
                make.left.right.equalTo(self.usernameTextField)
                make.height.equalTo(40)
            }
            self.signUpButton.snp.makeConstraints { make in
                make.top.equalTo(self.loginButton.snp.bottom).offset(15)
                make.left.right.equalTo(self.usernameTextField)
                make.height.equalTo(40)
            }
        }
        super.updateViewConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    // cancel
    func cancelButtonDidTap() {
        AppDelegate.instance?.GeneralUsersTabBarScreen(selectIndex: 1)
    }
    
    func textFieldDidChangeText(_ textField: UITextField) {
        textField.textColor = .black
    }
    
    //로그인
    func loginButtonDidTap() {
        guard let username = self.usernameTextField.text, !username.isEmpty else {
            UICommonSetShakeTextField(self.usernameTextField)
            return
        }
        guard let password = self.passwordTextField.text, !password.isEmpty else {
            UICommonSetShakeTextField(self.passwordTextField)
            return
        }
        
        //로그인
        restaurantLogin()
    }
    
    //회원 가입
    func signUpButtonDidTap() {
        AppDelegate.instance?.BusinessUsersSignUpScreen()
    }
    
    //로그인
    func restaurantLogin() {
        self.activityIndicatorView.startAnimating()
        BusinessUsersNetWorking.restaurantLogin(id: self.usernameTextField.text!, password: self.passwordTextField.text!) { [weak self] response in
            guard let `self` = self else { return }
            self.activityIndicatorView.stopAnimating()
            if response.count > 0 {
                //인증
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
                            //TODO : message를 이용한 focus 처리
                            //TODO : 서버 단절시 확인
                    }
                    alertController.addAction(alertConfirm)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    AppDelegate.instance?.BusinessUsersTabBarScreen(selectIndex: 0)
                }
            }
        }
    }
}

extension Login: UITextFieldDelegate {
    //TextField 리턴키 처리
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField.isEqual(self.usernameTextField)){
            guard let username = self.usernameTextField.text, !username.isEmpty else {
                UICommonSetShakeTextField(self.usernameTextField)
                return true
            }
            self.passwordTextField.becomeFirstResponder()
            return true
        } else if(textField.isEqual(self.passwordTextField)){
            guard let password = self.passwordTextField.text, !password.isEmpty else {
                UICommonSetShakeTextField(self.passwordTextField)
                return true
            }
            loginButtonDidTap()
            return true
        }
        return true
    }
}

