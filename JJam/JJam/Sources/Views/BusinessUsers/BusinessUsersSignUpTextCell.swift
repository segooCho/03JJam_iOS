//
//  BusinessUsersSignUpTextCell.swift
//  JJam
//
//  Created by admin on 2017. 7. 20..
//  Copyright © 2017년 admin. All rights reserved.
//


import UIKit

final class BusinessUsersSignUpTextCell: UITableViewCell {
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
    //아이디
    fileprivate let idLabel = UILabel()
    fileprivate let idTextField = UITextField()
    //패스워드
    fileprivate let passwordLabel = UILabel()
    fileprivate let passwordTextField = UITextField()
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
    
    
    //MARK: init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        //TODO :: SelectBox 처리
        UICommonSetLabel(self.idLabel, text: "아이디")
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
        self.setNeedsLayout()
    }
    
    //MARK: Size
    class func height() -> CGFloat {
        var height: CGFloat = 0
        
        //TextField 6개
        //TextView  1개
        height += Metric.commonOffset * 7
        height += Metric.commonHeight * 6
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
    }
}