//
//  UICommonSet.swift
//  JJam
//
//  Created by admin on 2017. 7. 18..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

//MARK: UISegmentedControl Common Set
func UICommonSetSegmentedControl(_ uIKit: UISegmentedControl, titles: Array<String>) {
    for (index, title) in titles.enumerated() {
        uIKit.insertSegment(withTitle: title, at: index, animated: false)
    }
}


//MARK: UILabel Common Set
func UICommonSetLabel(_ uIKit: UILabel, text: String, color: Int) {
    switch color {
    case 1:
        uIKit.textColor = .red
    case 2:
        uIKit.textColor = .blue
    default:
        uIKit.textColor = .black
    }

    uIKit.font = Font.font16
    uIKit.text = text
}

//MARK: UIButton Common Set
func UICommonSetButton(_ uIKit: UIButton, setTitleText: String, color: Int) {
    switch color {
    case 1:
        uIKit.backgroundColor = .red
    default:
        uIKit.backgroundColor = uIKit.tintColor
    }
    
    uIKit.layer.cornerRadius = 5
    uIKit.titleLabel?.font = Font.font16
    uIKit.setTitle(setTitleText, for: .normal)
}

//MARK: Common Set UITextField isEnabled = false
func UICommonSetTextFieldDisable(_ uIKit: UITextField) {
    uIKit.font = Font.font16
    uIKit.borderStyle = .roundedRect
    uIKit.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1.0)
    uIKit.isEnabled = false
}

//MARK: Common Set UITextField isEnabled = true
func UICommonSetTextFieldEnable(_ uIKit: UITextField, placeholderText: String) {
    uIKit.font = Font.font16
    uIKit.borderStyle = .roundedRect
    uIKit.placeholder = placeholderText
    uIKit.isEnabled = true
    uIKit.autocorrectionType = .no          //첫글자 소문자
    uIKit.autocapitalizationType = .none    //오타 교정
    uIKit.returnKeyType = .done             //리턴키 done
}

//MARK: Common Set UITextView isEnabled = false
func UICommonSetTextViewDisable(_ uIKit: UITextView) {
    let color = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0).cgColor
    uIKit.layer.borderColor = color
    uIKit.layer.borderWidth = 0.5
    uIKit.layer.cornerRadius = 5
    uIKit.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1.0)
    uIKit.font = Font.font16
    uIKit.isEditable = false
}

//MARK: Common Set UITextView isEnabled = true
func UICommonSetTextViewEnable(_ uIKit: UITextView, placeholderText: String) {
    let color = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0).cgColor
    uIKit.layer.borderColor = color
    uIKit.layer.borderWidth = 0.5
    uIKit.layer.cornerRadius = 5
    uIKit.font = Font.font16
    uIKit.placeholder = placeholderText
    uIKit.isEditable = true
}

//MARK: Common Set Shake UITextField
func UICommonSetShakeTextField(_ uIKit: UITextField) {
    uIKit.becomeFirstResponder()
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

//MARK: Common Set Shake UITextView
func UICommonSetShakeTextView(_ uIKit: UITextView) {
    uIKit.becomeFirstResponder()
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

//MARK: Common Set Loading
func UICommonSetLoading(_ uiKit: UIActivityIndicatorView) {
    uiKit.transform = CGAffineTransform(scaleX: 2, y: 2)
}

//MARK: Common Set Loading
func UICommonSetLoadingService(_ uIKit: UIActivityIndicatorView, service: Bool) {
    switch service {
    case true:
        uIKit.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        print("startAnimating")
    default:
        uIKit.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
        print("stopAnimating")
    }
}

/*
//MARK: Common Set UIDatePicker
func UICommonSetDatePicker(_ uIKit: UIDatePicker, view: UIView, textField: UITextField) {
     uIKit.datePickerMode = .date
    
    let toolbar = UIToolbar();
    toolbar.sizeToFit()
    
    //done button & cancel button
    let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.bordered, target: view, action: "donedatePicker")
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.bordered, target: view, action: "cancelDatePicker")
    toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
    
    // add toolbar to textField
    textField.inputAccessoryView = toolbar
    // add datepicker to textField
    textField.inputView = uIKit
}
*/

