//
//  BusinessUsersSignUpTextCell.swift
//  JJam
//
//  Created by admin on 2017. 7. 20..
//  Copyright © 2017년 admin. All rights reserved.
//


import UIKit

final class BusinessUsersSignUpTextCell: UITableViewCell {
    //MARK: Properties
    struct signUp {
        static var id: String = ""
        static var password: String = ""
        static var password2: String = ""
        static var businessNumber: String = ""
        static var companyName: String = ""
        static var address: String = ""
        static var contactNumber: String = ""
        static var representative: String = ""
    }
    
    //MARK: Constants
    fileprivate struct Metric {
        static let labelLeft = CGFloat(10)
        static let labelRight = CGFloat(-250)
        
        static let textFieldLeft = CGFloat(130)
        static let textFieldRight = CGFloat(-10)
        
        static let commonOffset = CGFloat(5)
        static let commonHeight = CGFloat(30)
        static let commonHeightTextView = CGFloat(100)
    }
    
    //MARK: UI
    //사용자ID
    fileprivate let idLabel = UILabel()
    fileprivate let idTextField = UITextField()
    //패스워드
    fileprivate let passwordLabel = UILabel()
    public let passwordTextField = UITextField()
    //패스워드2
    fileprivate let password2Label = UILabel()
    fileprivate let password2TextField = UITextField()
    //사업자번호
    fileprivate let businessNumberLabel = UILabel()
    fileprivate let businessNumberTextField = UITextField()
    //상호
    fileprivate let companyNameLabel = UILabel()
    fileprivate let companyNameTextField = UITextField()
    //주소
    fileprivate let addressLabel = UILabel()
    fileprivate let addressTextView = UITextView()
    //연락처
    fileprivate let contactNumberLabel = UILabel()
    fileprivate let contactNumberTextField = UITextField()
    //대표자
    fileprivate let representativeLabel = UILabel()
    fileprivate let representativeTextField = UITextField()
    
    //MARK: init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        UICommonSetLabel(self.idLabel, text: "사용자ID", color: 1)
        UICommonSetTextFieldEnable(self.idTextField, placeholderText: self.idLabel.text!)
        self.idTextField.delegate = self

        UICommonSetLabel(self.passwordLabel, text: "암호", color: 1)
        UICommonSetTextFieldEnable(self.passwordTextField, placeholderText: self.passwordLabel.text!)
        self.passwordTextField.delegate = self
        self.passwordTextField.isSecureTextEntry = true
        
        UICommonSetLabel(self.password2Label, text: "암호 확인", color: 1)
        UICommonSetTextFieldEnable(self.password2TextField, placeholderText: self.password2Label.text!)
        self.password2TextField.delegate = self
        self.password2TextField.isSecureTextEntry = true
        
        UICommonSetLabel(self.businessNumberLabel, text: "사업자 번호", color: 1)
        UICommonSetTextFieldEnable(self.businessNumberTextField, placeholderText: self.businessNumberLabel.text!)
        self.businessNumberTextField.delegate = self
        
        UICommonSetLabel(self.companyNameLabel, text: "상호", color: 1)
        UICommonSetTextFieldEnable(self.companyNameTextField, placeholderText: self.companyNameLabel.text!)
        self.companyNameTextField.delegate = self
        
        UICommonSetLabel(self.addressLabel, text: "주소", color: 1)
        UICommonSetTextViewEnable(self.addressTextView, placeholderText: self.addressLabel.text!)
        //self.addressTextView.delegate = self
        
        UICommonSetLabel(self.contactNumberLabel, text: "연락처", color: 1)
        UICommonSetTextFieldEnable(self.contactNumberTextField, placeholderText: self.contactNumberLabel.text!)
        self.contactNumberTextField.delegate = self
        
        UICommonSetLabel(self.representativeLabel, text: "대표자", color: 1)
        UICommonSetTextFieldEnable(self.representativeTextField, placeholderText: self.representativeLabel.text!)
        self.representativeTextField.delegate = self


        
        self.contentView.addSubview(self.idLabel)
        self.contentView.addSubview(self.idTextField)
        self.contentView.addSubview(self.passwordLabel)
        self.contentView.addSubview(self.passwordTextField)
        self.contentView.addSubview(self.password2Label)
        self.contentView.addSubview(self.password2TextField)
        self.contentView.addSubview(self.businessNumberLabel)
        self.contentView.addSubview(self.businessNumberTextField)
        self.contentView.addSubview(self.companyNameLabel)
        self.contentView.addSubview(self.companyNameTextField)
        self.contentView.addSubview(self.addressLabel)
        self.contentView.addSubview(self.addressTextView)
        self.contentView.addSubview(self.contactNumberLabel)
        self.contentView.addSubview(self.contactNumberTextField)
        self.contentView.addSubview(self.representativeLabel)
        self.contentView.addSubview(self.representativeTextField)
        
        self.idTextField.becomeFirstResponder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: configure
    func configure(signUp: SignUp) {
        /*
        signUp.id = self.idTextField.text!
        signUp.password = self.passwordTextField.text!
        signUp.password2 = self.password2TextField.text!
        signUp.businessNumber = self.businessNumberTextField.text!
        signUp.companyName = self.companyNameTextField.text!
        signUp.address = self.addressTextView.text!
        signUp.contactNumber = self.contactNumberTextField.text!
        signUp.representative = self.representativeTextField.text!
        */
        
        self.idTextField.text = signUp.id
        self.passwordTextField.text = ""
        self.password2TextField.text = ""
        self.businessNumberTextField.text = signUp.businessNumber
        self.companyNameTextField.text = signUp.companyName
        self.addressTextView.text = signUp.address
        self.contactNumberTextField.text = signUp.contactNumber
        self.representativeTextField.text = signUp.representative
        self.setNeedsLayout()
    }

    //BusinessUsersSignUp에서 struct의 값을 접근하기 전에 값을 셋팅힌다.
    func setInputData() -> String {
        signUp.id = ""
        signUp.password = ""
        signUp.password2 = ""
        signUp.businessNumber = ""
        signUp.companyName = ""
        signUp.address = ""
        signUp.contactNumber = ""
        signUp.representative = ""

        
        var inputText = ""
        inputText = self.idTextField.text!
        if inputText == self.idTextField.text, inputText.isEmpty {
            self.idTextField.becomeFirstResponder()
            return "사용자 ID를 입력하세요."
            //return false
        }
        inputText = self.passwordTextField.text!
        if inputText.isEmpty {
            self.passwordTextField.becomeFirstResponder()
            return "암호를 입력하세요."
        } else if inputText.characters.count < 4 {
            self.passwordTextField.becomeFirstResponder()
            return "암호를 4자리 이상 입력하세요."
        }
        if self.passwordTextField.text != self.password2TextField.text {
            self.password2TextField.becomeFirstResponder()
            return "암호가 다릅니다."
        }
        inputText = self.businessNumberTextField.text!
        if inputText.isEmpty {
            self.businessNumberTextField.becomeFirstResponder()
            return "사업자 번호를 입력하세요."
        }
        inputText = self.companyNameTextField.text!
        if inputText.isEmpty {
            self.companyNameTextField.becomeFirstResponder()
            return "상호를 입력하세요."
        }
        inputText = self.addressTextView.text!
        if inputText.isEmpty {
            self.addressTextView.becomeFirstResponder()
            return "주소를 입력하세요."
        }
        inputText = self.contactNumberTextField.text!
        if inputText.isEmpty {
            self.contactNumberTextField.becomeFirstResponder()
            return "연락처를 입력하세요."
        }
        inputText = self.representativeTextField.text!
        if inputText.isEmpty {
            self.representativeTextField.becomeFirstResponder()
            return "대표자를 입력하세요."
        }
        
        signUp.id = self.idTextField.text!
        signUp.password = self.passwordTextField.text!
        signUp.password2 = self.password2TextField.text!
        signUp.businessNumber = self.businessNumberTextField.text!
        signUp.companyName = self.companyNameTextField.text!
        signUp.address = self.addressTextView.text!
        signUp.contactNumber = self.contactNumberTextField.text!
        signUp.representative = self.representativeTextField.text!
        
        return ""
    }
    
    //MARK: Size
    class func height() -> CGFloat {
        var height: CGFloat = 0
        
        //TextField 7개
        //TextView  1개
        height += Metric.commonOffset * 8
        height += Metric.commonHeight * 7
        height += Metric.commonHeightTextView
        height += Metric.commonOffset   //하단 여백 처리
        return height
    }
    
    //MARK: Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        //아이디
        self.idLabel.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.contentView).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.idTextField.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.contentView).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        
        //패스워드
        self.passwordLabel.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.idLabel.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.passwordTextField.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.idLabel.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        
        //패스워드2
        self.password2Label.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.passwordLabel.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.password2TextField.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.passwordLabel.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        
        //사업자 번호
        self.businessNumberLabel.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.password2Label.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.businessNumberTextField.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.password2Label.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        
        //상호
        self.companyNameLabel.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.businessNumberLabel.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.companyNameTextField.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.businessNumberLabel.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        
        //주소
        self.addressLabel.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.companyNameLabel.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.addressTextView.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.companyNameLabel.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeightTextView)
        }
        
        //연락처
        self.contactNumberLabel.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.addressTextView.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.contactNumberTextField.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.addressTextView.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        
        //대표자
        self.representativeLabel.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.contactNumberLabel.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.representativeTextField.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.contactNumberLabel.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
    }
}

extension BusinessUsersSignUpTextCell: UITextFieldDelegate {
    //TextField 리턴키 처리
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.contentView.endEditing(true)
        return true
    }
}


