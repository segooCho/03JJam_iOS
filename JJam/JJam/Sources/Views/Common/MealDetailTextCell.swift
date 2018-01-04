//
//  MealDetailTextCell.swift
//  JJam
//
//  Created by admin on 2017. 7. 17..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit
import DownPicker

final class MealDetailTextCell: UITableViewCell {
    //MARK: Properties
    struct tableViewCellMeal {
        static var businessUsersMeal: [BusinessUsersMeal] = []
    }
    
    //MARK: Constants
    fileprivate struct Metric {
        static let labelLeft = CGFloat(10)
        static let labelRight = CGFloat(-270)

        static let textFieldLeft = CGFloat(120)
        static let textFieldRight = CGFloat(-10)
        
        static let commonOffset = CGFloat(7)
        static let commonHeight = CGFloat(45)
        static let commonHeightTextView = CGFloat(100)
    }
    
    //MARK: UI
    //일자
    fileprivate let dateLabel = UILabel()
    fileprivate let dateTextField = UITextField()
    fileprivate var datePicker = UIDatePicker()
    //위치
    fileprivate let locationLabel = UILabel()
    fileprivate let locationTextField = UITextField()
    fileprivate var locationDownPicker: DownPicker!
    //구분
    fileprivate let divisionLabel = UILabel()
    fileprivate let divisionTextField = UITextField()
    fileprivate var divisionDownPicker: DownPicker!
    //주식
    fileprivate let stapleFoodLabel = UILabel()
    fileprivate let stapleFoodTextField = UITextField()
    fileprivate var stapleFoodDownPicker: DownPicker!
    //국
    fileprivate let soupLabel = UILabel()
    fileprivate let soupTextField = UITextField()
    fileprivate var soupDownPicker: DownPicker!
    //반찬1
    fileprivate let sideDish1Label = UILabel()
    fileprivate let sideDish1TextField = UITextField()
    fileprivate var sideDish1DownPicker: DownPicker!
    //반찬2
    fileprivate let sideDish2Label = UILabel()
    fileprivate let sideDish2TextField = UITextField()
    fileprivate var sideDish2DownPicker: DownPicker!
    //반찬3
    fileprivate let sideDish3Label = UILabel()
    fileprivate let sideDish3TextField = UITextField()
    fileprivate var sideDish3DownPicker: DownPicker!
    //반찬4
    fileprivate let sideDish4Label = UILabel()
    fileprivate let sideDish4TextField = UITextField()
    fileprivate var sideDish4DownPicker: DownPicker!
    //후식
    fileprivate let dessertLabel = UILabel()
    fileprivate let dessertTextField = UITextField()
    fileprivate var dessertDownPicker: DownPicker!
    //비고
    fileprivate let remarksLabel = UILabel()
    fileprivate let remarksTextView = UITextView()
    

    //MARK: init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: configure
    func configure(meal: Meal) {
        if controlTuple.editMode {
            UICommonSetLabel(self.dateLabel, text: "일자", color: 1)
            if controlTuple.writeMode {
                UICommonSetTextFieldEnable(self.dateTextField, placeholderText: "")
            } else {
                UICommonSetTextFieldDisable(self.dateTextField)
            }

            //datePicker
            //UICommonSetDatePicker(self.datePicker, view: self.contentView, textField: )
            self.datePicker.datePickerMode = .date
            let toolbar = UIToolbar();
            toolbar.sizeToFit()
            //done button & cancel button
            let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: "donedatePicker")
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
            let cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: "cancelDatePicker")
            toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
            // add toolbar to textField
            self.dateTextField.inputAccessoryView = toolbar
            // add datepicker to textField
            self.dateTextField.inputView = self.datePicker
            
            UICommonSetLabel(self.locationLabel, text: "위치", color: 1)
            UICommonSetTextFieldEnable(self.locationTextField, placeholderText: "")
            self.locationDownPicker = DownPicker(textField: self.locationTextField, withData:BusinessGroupArray.location as! [Any])
            
            UICommonSetLabel(self.divisionLabel, text: "구분", color: 1)
            UICommonSetTextFieldEnable(self.divisionTextField, placeholderText: "")
            self.divisionDownPicker = DownPicker(textField: self.divisionTextField, withData:BusinessGroupArray.division as! [Any])
            
            UICommonSetLabel(self.stapleFoodLabel, text: "주식(밥,면)", color: 0)
            UICommonSetTextFieldEnable(self.stapleFoodTextField, placeholderText: "")
            self.stapleFoodDownPicker = DownPicker(textField: self.stapleFoodTextField, withData:BusinessGroupArray.stapleFood as! [Any])
            
            UICommonSetLabel(self.soupLabel, text: "국", color: 0)
            UICommonSetTextFieldEnable(self.soupTextField, placeholderText: "")
            self.soupDownPicker = DownPicker(textField: self.soupTextField, withData:BusinessGroupArray.soup as! [Any])
            
            UICommonSetLabel(self.sideDish1Label, text: "반찬1", color: 0)
            UICommonSetTextFieldEnable(self.sideDish1TextField, placeholderText: "")
            self.sideDish1DownPicker = DownPicker(textField: self.sideDish1TextField, withData:BusinessGroupArray.sideDish as! [Any])
            
            UICommonSetLabel(self.sideDish2Label, text: "반찬2", color: 0)
            UICommonSetTextFieldEnable(self.sideDish2TextField, placeholderText: "")
            self.sideDish2DownPicker = DownPicker(textField: self.sideDish2TextField, withData:BusinessGroupArray.sideDish as! [Any])
            
            UICommonSetLabel(self.sideDish3Label, text: "반찬3", color: 0)
            UICommonSetTextFieldEnable(self.sideDish3TextField, placeholderText: "")
            self.sideDish3DownPicker = DownPicker(textField: self.sideDish3TextField, withData:BusinessGroupArray.sideDish as! [Any])
            
            UICommonSetLabel(self.sideDish4Label, text: "반찬4", color: 0)
            UICommonSetTextFieldEnable(self.sideDish4TextField, placeholderText: "")
            self.sideDish4DownPicker = DownPicker(textField: self.sideDish4TextField, withData:BusinessGroupArray.sideDish as! [Any])
            
            UICommonSetLabel(self.dessertLabel, text: "후식", color: 0)
            UICommonSetTextFieldEnable(self.dessertTextField, placeholderText: "")
            self.dessertDownPicker = DownPicker(textField: self.dessertTextField, withData:BusinessGroupArray.dessert as! [Any])
            
            UICommonSetLabel(self.remarksLabel, text: "비고", color: 0)
            UICommonSetTextViewEnable(self.remarksTextView, placeholderText: "")
        } else {
            UICommonSetLabel(self.dateLabel, text: "일자", color: 0)
            UICommonSetTextFieldDisable(self.dateTextField)
            
            UICommonSetLabel(self.locationLabel, text: "위치", color: 0)
            UICommonSetTextFieldDisable(self.locationTextField)
            
            UICommonSetLabel(self.divisionLabel, text: "구분", color: 0)
            UICommonSetTextFieldDisable(self.divisionTextField)
            
            UICommonSetLabel(self.stapleFoodLabel, text: "주식(밥,면)", color: 0)
            UICommonSetTextFieldDisable(self.stapleFoodTextField)
            
            UICommonSetLabel(self.soupLabel, text: "국", color: 0)
            UICommonSetTextFieldDisable(self.soupTextField)
            
            UICommonSetLabel(self.sideDish1Label, text: "반찬1", color: 0)
            UICommonSetTextFieldDisable(self.sideDish1TextField)
            
            UICommonSetLabel(self.sideDish2Label, text: "반찬2", color: 0)
            UICommonSetTextFieldDisable(self.sideDish2TextField)
            
            UICommonSetLabel(self.sideDish3Label, text: "반찬3", color: 0)
            UICommonSetTextFieldDisable(self.sideDish3TextField)
            
            UICommonSetLabel(self.sideDish4Label, text: "반찬4", color: 0)
            UICommonSetTextFieldDisable(self.sideDish4TextField)
            
            UICommonSetLabel(self.dessertLabel, text: "후식", color: 0)
            UICommonSetTextFieldDisable(self.dessertTextField)
            
            UICommonSetLabel(self.remarksLabel, text: "비고", color: 0)
            UICommonSetTextViewDisable(self.remarksTextView)
        }
        
        self.contentView.addSubview(self.dateLabel)
        self.contentView.addSubview(self.dateTextField)
        self.contentView.addSubview(self.locationLabel)
        self.contentView.addSubview(self.locationTextField)
        self.contentView.addSubview(self.divisionLabel)
        self.contentView.addSubview(self.divisionTextField)
        self.contentView.addSubview(self.stapleFoodLabel)
        self.contentView.addSubview(self.stapleFoodTextField)
        self.contentView.addSubview(self.soupLabel)
        self.contentView.addSubview(self.soupTextField)
        self.contentView.addSubview(self.sideDish1Label)
        self.contentView.addSubview(self.sideDish1TextField)
        self.contentView.addSubview(self.sideDish2Label)
        self.contentView.addSubview(self.sideDish2TextField)
        self.contentView.addSubview(self.sideDish3Label)
        self.contentView.addSubview(self.sideDish3TextField)
        self.contentView.addSubview(self.sideDish4Label)
        self.contentView.addSubview(self.sideDish4TextField)
        self.contentView.addSubview(self.dessertLabel)
        self.contentView.addSubview(self.dessertTextField)
        self.contentView.addSubview(self.remarksLabel)
        self.contentView.addSubview(self.remarksTextView)
        
        //일자
        if controlTuple.editMode {
            self.dateTextField.text = meal.mealDate
            self.dateTextField.becomeFirstResponder()
        } else {
            self.dateTextField.text = meal.mealDate + " (" + meal.mealDateLabel + ")"
        }
        
        self.locationTextField.text = meal.location
        self.divisionTextField.text = meal.division
        self.stapleFoodTextField.text = meal.stapleFood
        self.soupTextField.text = meal.soup
        self.sideDish1TextField.text = meal.sideDish1
        self.sideDish2TextField.text = meal.sideDish2
        self.sideDish3TextField.text = meal.sideDish3
        self.sideDish4TextField.text = meal.sideDish4
        self.dessertTextField.text = meal.dessert
        //self.remarksTextView.text = meal.remarks.replacingOccurrences(of: "\\n", with: "\n")
        self.remarksTextView.text = meal.remarks
        self.setNeedsLayout()
    }
    
    //MealDetailTextCell에서 struct의 값을 접근하기 전에 값을 셋팅힌다.
    func setInputData() -> String {
        tableViewCellMeal.businessUsersMeal.removeAll()
        tableViewCellMeal.businessUsersMeal.append(
            BusinessUsersMeal(mealDate: "",
                              location: "",
                              division: "",
                              stapleFood: "",
                              soup: "",
                              sideDish1: "",
                              sideDish2: "",
                              sideDish3: "",
                              sideDish4: "",
                              dessert: "",
                              remarks: ""))

        var inputText = ""
        inputText = self.dateTextField.text!
        if inputText.isEmpty {
            self.dateTextField.becomeFirstResponder()
            return "일자를 선택하세요."
        }
        inputText = self.locationTextField.text!
        if inputText.isEmpty {
            self.locationTextField.becomeFirstResponder()
            return "위치를 선택하세요."
        }
        inputText = self.divisionTextField.text!
        if inputText.isEmpty {
            self.divisionTextField.becomeFirstResponder()
            return "구분을 선택하세요."
        }

        tableViewCellMeal.businessUsersMeal.removeAll()
        tableViewCellMeal.businessUsersMeal.append(
            BusinessUsersMeal(mealDate: self.dateTextField.text!,
                              location: self.locationTextField.text!,
                              division: self.divisionTextField.text!,
                              stapleFood: self.stapleFoodTextField.text!,
                              soup: self.soupTextField.text!,
                              sideDish1: self.sideDish1TextField.text!,
                              sideDish2: self.sideDish2TextField.text!,
                              sideDish3: self.sideDish3TextField.text!,
                              sideDish4: self.sideDish4TextField.text!,
                              dessert: self.dessertTextField.text!,
                              remarks: self.remarksTextView.text!))
        return ""
    }

    
    //MARK: Size
    class func height() -> CGFloat {
        var height: CGFloat = 0

        //TextField 10개
        //TextView  1개
        height += Metric.commonOffset * 11
        height += Metric.commonHeight * 10
        height += Metric.commonHeightTextView
        height += Metric.commonOffset   //하단 여백 처리
        return height
    }
    
    //MARK: Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        //self.dateTextField.frame = self.contentView.bounds //채우기
        //일자
        self.dateLabel.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.contentView.snp.top).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.dateTextField.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.contentView.snp.top).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        
        //위치
        self.locationLabel.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.dateLabel.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.locationTextField.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.dateLabel.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }

        //구분
        self.divisionLabel.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.locationLabel.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.divisionTextField.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.locationLabel.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        
        //주식(밥,면)
        self.stapleFoodLabel.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.divisionLabel.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.stapleFoodTextField.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.divisionLabel.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        
        //국
        self.soupLabel.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.stapleFoodLabel.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.soupTextField.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.stapleFoodLabel.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }

        //반찬1
        self.sideDish1Label.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.soupLabel.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.sideDish1TextField.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.soupLabel.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        
        //반찬2
        self.sideDish2Label.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.sideDish1Label.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.sideDish2TextField.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.sideDish1Label.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        
        //반찬3
        self.sideDish3Label.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.sideDish2Label.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.sideDish3TextField.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.sideDish2Label.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }

        //반찬4
        self.sideDish4Label.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.sideDish3Label.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.sideDish4TextField.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.sideDish3Label.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }

        //후식
        self.dessertLabel.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.sideDish4Label.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.dessertTextField.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.sideDish4Label.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        
        //비고
        self.remarksLabel.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.dessertLabel.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.remarksTextView.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.dessertLabel.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeightTextView)
        }
    }
    
    //MARK: Action
    func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        self.dateTextField.text = formatter.string(from: datePicker.date)
        self.contentView.endEditing(true)
    }
    
    func cancelDatePicker(){
        self.contentView.endEditing(true)
    }
}
