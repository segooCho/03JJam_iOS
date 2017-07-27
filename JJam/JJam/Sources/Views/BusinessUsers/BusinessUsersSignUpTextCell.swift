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
        static var id = ""
        static var password = ""
        static var password2 = ""
        static var businessNumber = ""
        static var companyName = ""
        static var address = ""
        static var contactNumber = ""
        static var representative = ""
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
        
        UICommonSetLabel(self.idLabel, text: "사용자ID")
        UICommonSetTextFieldEnable(self.idTextField, placeholderText: self.idLabel.text!)
        
        UICommonSetLabel(self.passwordLabel, text: "패스워드")
        UICommonSetTextFieldEnable(self.passwordTextField, placeholderText: self.passwordLabel.text!)
        self.passwordTextField.isSecureTextEntry = true
        
        UICommonSetLabel(self.password2Label, text: "패스워드 확인")
        UICommonSetTextFieldEnable(self.password2TextField, placeholderText: self.password2Label.text!)
        self.password2TextField.isSecureTextEntry = true
        
        UICommonSetLabel(self.businessNumberLabel, text: "사업자 번호")
        UICommonSetTextFieldEnable(self.businessNumberTextField, placeholderText: self.businessNumberLabel.text!)
        
        UICommonSetLabel(self.companyNameLabel, text: "상호")
        UICommonSetTextFieldEnable(self.companyNameTextField, placeholderText: self.companyNameLabel.text!)
        
        UICommonSetLabel(self.addressLabel, text: "주소")
        UICommonSetTextViewEnable(self.addressTextView, placeholderText: self.addressLabel.text!)
        
        UICommonSetLabel(self.contactNumberLabel, text: "연락처")
        UICommonSetTextFieldEnable(self.contactNumberTextField, placeholderText: self.contactNumberLabel.text!)
        
        UICommonSetLabel(self.representativeLabel, text: "대표자")
        UICommonSetTextFieldEnable(self.representativeTextField, placeholderText: self.representativeLabel.text!)
        
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
        
        self.idTextField.delegate = self
        self.passwordTextField.delegate = self
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: configure
    func configure(signUp: SignUp) {
        self.idTextField.text = signUp.id
        self.passwordTextField.text = signUp.password
        self.password2TextField.text = signUp.password2
        self.businessNumberTextField.text = signUp.businessNumber
        self.companyNameTextField.text = signUp.companyName
        self.addressTextView.text = signUp.address
        self.contactNumberTextField.text = signUp.contactNumber
        self.representativeTextField.text = signUp.representative
        self.setNeedsLayout()
    }

    func setInputData(){
        signUp.id = self.idTextField.text!
        signUp.password = self.passwordTextField.text!
        signUp.password2 = self.password2TextField.text!
        signUp.businessNumber = self.businessNumberTextField.text!
        signUp.companyName = self.companyNameTextField.text!
        signUp.address = self.addressTextView.text!
        signUp.contactNumber = self.contactNumberTextField.text!
        signUp.representative = self.representativeTextField.text!
        print("setInputData / id :", signUp.id)
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
    //TextField 포커스 아웃
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        //signUp.id = self.idTextField.text!
        //signUp.password = self.passwordTextField.text!
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) -> Bool {
        //signUp.id = self.idTextField.text!
        //signUp.password = self.passwordTextField.text!
        return true
        
    }
    
}




