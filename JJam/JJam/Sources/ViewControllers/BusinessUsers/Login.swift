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
        
        UICommonSetTextFieldEnable(self.passwordTextField, placeholderText: "패스워드")
        self.passwordTextField.isSecureTextEntry = true
        self.passwordTextField.addTarget(self, action: #selector(textFieldDidChangeText), for: .editingChanged)
        
        
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
        self.passwordTextField.becomeFirstResponder()
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
    func cancelButtonDidTap() {
        AppDelegate.instance?.GeneralUsersTabBarScreen(selectIndex: 1)
    }
    
    func textFieldDidChangeText(_ textField: UITextField) {
        textField.textColor = .black
    }
    
    func loginButtonDidTap() {
        guard let username = self.usernameTextField.text, !username.isEmpty else {
            self.usernameTextField.becomeFirstResponder()
            UICommonSetShakeTextField(self.usernameTextField)
            return
        }
        guard let password = self.passwordTextField.text, !password.isEmpty else {
            self.passwordTextField.becomeFirstResponder()
            UICommonSetShakeTextField(self.passwordTextField)
            return
        }
        
        self.usernameTextField.isEnabled = false
        self.passwordTextField.isEnabled = false
        self.loginButton.isEnabled = false
        self.signUpButton.isEnabled = false
        self.loginButton.alpha = 0.4
        self.signUpButton.alpha = 0.4
        
        //TODO ::통신 처리
        AppDelegate.instance?.BusinessUsersTabBarScreen(selectIndex: 0)
    }
    
    func signUpButtonDidTap() {
        AppDelegate.instance?.BusinessUsersSignUpScreen()
    }
    
}

