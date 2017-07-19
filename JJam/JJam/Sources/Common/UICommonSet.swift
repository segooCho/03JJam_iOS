//
//  UICommonSet.swift
//  JJam
//
//  Created by admin on 2017. 7. 18..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

//MARK: Constants
fileprivate struct Font {
    static let font14 = UIFont.systemFont(ofSize: 14)
}

//MARK: UILabel Common Set
func UICommonSetLabel(_ uIKit: UILabel, text: String) {
    uIKit.font = Font.font14
    uIKit.text = text
}

//MARK: UIButton Common Set
func UICommonSetButton(_ uIKit: UIButton, setTitleText: String, colorInt: Int) {
    if (colorInt == 0){
        uIKit.backgroundColor = uIKit.tintColor
    } else {
        uIKit.backgroundColor = .red
    }
    
    uIKit.layer.cornerRadius = 5
    uIKit.titleLabel?.font = Font.font14
    uIKit.setTitle(setTitleText, for: .normal)
}

//MARK: Common Set UITextField isEnabled = false
func UICommonSetTextFieldDisable(_ uIKit: UITextField) {
    uIKit.font = Font.font14
    uIKit.borderStyle = .roundedRect
    uIKit.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1.0)
    uIKit.isEnabled = false
}

//MARK: Common Set UITextField isEnabled = true
func UICommonSetTextFieldEnable(_ uIKit: UITextField, placeholderText: String) {
    uIKit.font = Font.font14
    uIKit.borderStyle = .roundedRect
    uIKit.placeholder = placeholderText
    uIKit.isEnabled = true
    uIKit.autocorrectionType = .no          //첫글자 소문자
    uIKit.autocapitalizationType = .none    //오타 교정
}

//MARK: Common Set UITextView isEnabled = false
func UICommonSetTextViewDisable(_ uIKit: UITextView) {
    let color = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0).cgColor
    uIKit.layer.borderColor = color
    uIKit.layer.borderWidth = 0.5
    uIKit.layer.cornerRadius = 5
    uIKit.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1.0)
    uIKit.font = Font.font14
    uIKit.isEditable = false
}

//MARK: Common Set UITextView isEnabled = true
func UICommonSetTextViewEnable(_ uIKit: UITextView) {
    let color = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0).cgColor
    uIKit.layer.borderColor = color
    uIKit.layer.borderWidth = 0.5
    uIKit.layer.cornerRadius = 5
    uIKit.font = Font.font14
    uIKit.isEditable = true
}

//MARK: Common Set Shake UITextField
func UICommonSetShakeTextField(_ uIKit: UITextField) {
    UIView.animate(withDuration: 0.05, animations: { uIKit.frame.origin.x -= 5 }, completion: { _ in
        UIView.animate(withDuration: 0.05, animations: { uIKit.frame.origin.x += 10 }, completion: { _ in
            UIView.animate(withDuration: 0.05, animations: { uIKit.frame.origin.x -= 10 }, completion: { _ in
                UIView.animate(withDuration: 0.05, animations: { uIKit.frame.origin.x += 10 }, completion: { _ in
                    UIView.animate(withDuration: 0.05, animations: { uIKit.frame.origin.x -= 5 })
                })
            })
        })
    })
}

