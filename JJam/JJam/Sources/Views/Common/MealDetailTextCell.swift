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
    //주식1
    fileprivate let stapleFood1Label = UILabel()
    fileprivate let stapleFood1TextField = UITextField()
    fileprivate var stapleFood1DownPicker: DownPicker!
    //국2
    fileprivate let soup1Label = UILabel()
    fileprivate let soup1TextField = UITextField()
    fileprivate var soup1DownPicker: DownPicker!
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
    //반찬5
    fileprivate let sideDish5Label = UILabel()
    fileprivate let sideDish5TextField = UITextField()
    fileprivate var sideDish5DownPicker: DownPicker!
    //반찬6
    fileprivate let sideDish6Label = UILabel()
    fileprivate let sideDish6TextField = UITextField()
    fileprivate var sideDish6DownPicker: DownPicker!
    //반찬7
    fileprivate let sideDish7Label = UILabel()
    fileprivate let sideDish7TextField = UITextField()
    fileprivate var sideDish7DownPicker: DownPicker!
    //후식1
    fileprivate let dessert1Label = UILabel()
    fileprivate let dessert1TextField = UITextField()
    fileprivate var dessert1DownPicker: DownPicker!
    //후식2
    fileprivate let dessert2Label = UILabel()
    fileprivate let dessert2TextField = UITextField()
    fileprivate var dessert2DownPicker: DownPicker!
    //후식3
    fileprivate let dessert3Label = UILabel()
    fileprivate let dessert3TextField = UITextField()
    fileprivate var dessert3DownPicker: DownPicker!
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
            self.datePicker.datePickerMode = .date
            self.datePicker.locale = NSLocale(localeIdentifier: "ko_KR") as Locale

            let toolbar = UIToolbar();
            toolbar.sizeToFit()
            //done button & cancel button
            let doneButton = UIBarButtonItem(
                title: "완료",
                style: .done,
                target: self,
                action: #selector(MealDetailTextCell.donedatePicker)
            )
            let spaceButton = UIBarButtonItem(
                barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace,
                target: nil,
                action: nil
            )
            let cancelButton = UIBarButtonItem(
                title: "취소",
                style: .done,
                target: self,
                action: #selector(MealDetailTextCell.cancelDatePicker)
            )
            toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
            // add toolbar to textField
            self.dateTextField.inputAccessoryView = toolbar
            // add datepicker to textField
            self.dateTextField.inputView = self.datePicker

            
            UICommonSetLabel(self.locationLabel, text: "위치", color: 1)
            UICommonSetTextFieldEnable(self.locationTextField, placeholderText: "")
            self.locationDownPicker = DownPicker(textField: self.locationTextField, withData:BusinessGroupArray.location as! [Any])
            self.locationDownPicker.setPlaceholder("선택하세요.")
            self.locationDownPicker.setToolbarCancelButtonText("취소")
            self.locationDownPicker.setToolbarDoneButtonText("완료")

            UICommonSetLabel(self.divisionLabel, text: "구분", color: 1)
            UICommonSetTextFieldEnable(self.divisionTextField, placeholderText: "")
            self.divisionDownPicker = DownPicker(textField: self.divisionTextField, withData:BusinessGroupArray.division as! [Any])
            self.divisionDownPicker.setPlaceholder("선택하세요.")
            self.divisionDownPicker.setToolbarCancelButtonText("취소")
            self.divisionDownPicker.setToolbarDoneButtonText("완료")

            UICommonSetLabel(self.stapleFood1Label, text: "주식(밥,면)", color: 0)
            UICommonSetTextFieldEnable(self.stapleFood1TextField, placeholderText: "")
            self.stapleFood1DownPicker = DownPicker(textField: self.stapleFood1TextField, withData:BusinessGroupArray.stapleFood as! [Any])
            self.stapleFood1DownPicker.setPlaceholder("선택하세요.")
            self.stapleFood1DownPicker.setToolbarCancelButtonText("취소")
            self.stapleFood1DownPicker.setToolbarDoneButtonText("완료")

            UICommonSetLabel(self.soup1Label, text: "국", color: 0)
            UICommonSetTextFieldEnable(self.soup1TextField, placeholderText: "")
            self.soup1DownPicker = DownPicker(textField: self.soup1TextField, withData:BusinessGroupArray.soup as! [Any])
            self.soup1DownPicker.setPlaceholder("선택하세요.")
            self.soup1DownPicker.setToolbarCancelButtonText("취소")
            self.soup1DownPicker.setToolbarDoneButtonText("완료")

            UICommonSetLabel(self.sideDish1Label, text: "반찬", color: 0)
            UICommonSetTextFieldEnable(self.sideDish1TextField, placeholderText: "")
            self.sideDish1DownPicker = DownPicker(textField: self.sideDish1TextField, withData:BusinessGroupArray.sideDish as! [Any])
            self.sideDish1DownPicker.setPlaceholder("선택하세요.")
            self.sideDish1DownPicker.setToolbarCancelButtonText("취소")
            self.sideDish1DownPicker.setToolbarDoneButtonText("완료")

            UICommonSetLabel(self.sideDish2Label, text: "반찬", color: 0)
            UICommonSetTextFieldEnable(self.sideDish2TextField, placeholderText: "")
            self.sideDish2DownPicker = DownPicker(textField: self.sideDish2TextField, withData:BusinessGroupArray.sideDish as! [Any])
            self.sideDish2DownPicker.setPlaceholder("선택하세요.")
            self.sideDish2DownPicker.setToolbarCancelButtonText("취소")
            self.sideDish2DownPicker.setToolbarDoneButtonText("완료")

            UICommonSetLabel(self.sideDish3Label, text: "반찬", color: 0)
            UICommonSetTextFieldEnable(self.sideDish3TextField, placeholderText: "")
            self.sideDish3DownPicker = DownPicker(textField: self.sideDish3TextField, withData:BusinessGroupArray.sideDish as! [Any])
            self.sideDish3DownPicker.setPlaceholder("선택하세요.")
            self.sideDish3DownPicker.setToolbarCancelButtonText("취소")
            self.sideDish3DownPicker.setToolbarDoneButtonText("완료")

            UICommonSetLabel(self.sideDish4Label, text: "반찬", color: 0)
            UICommonSetTextFieldEnable(self.sideDish4TextField, placeholderText: "")
            self.sideDish4DownPicker = DownPicker(textField: self.sideDish4TextField, withData:BusinessGroupArray.sideDish as! [Any])
            self.sideDish4DownPicker.setPlaceholder("선택하세요.")
            self.sideDish4DownPicker.setToolbarCancelButtonText("취소")
            self.sideDish4DownPicker.setToolbarDoneButtonText("완료")

            UICommonSetLabel(self.sideDish5Label, text: "반찬", color: 0)
            UICommonSetTextFieldEnable(self.sideDish5TextField, placeholderText: "")
            self.sideDish5DownPicker = DownPicker(textField: self.sideDish5TextField, withData:BusinessGroupArray.sideDish as! [Any])
            self.sideDish5DownPicker.setPlaceholder("선택하세요.")
            self.sideDish5DownPicker.setToolbarCancelButtonText("취소")
            self.sideDish5DownPicker.setToolbarDoneButtonText("완료")

            UICommonSetLabel(self.sideDish6Label, text: "반찬", color: 0)
            UICommonSetTextFieldEnable(self.sideDish6TextField, placeholderText: "")
            self.sideDish6DownPicker = DownPicker(textField: self.sideDish6TextField, withData:BusinessGroupArray.sideDish as! [Any])
            self.sideDish6DownPicker.setPlaceholder("선택하세요.")
            self.sideDish6DownPicker.setToolbarCancelButtonText("취소")
            self.sideDish6DownPicker.setToolbarDoneButtonText("완료")

            UICommonSetLabel(self.sideDish7Label, text: "반찬", color: 0)
            UICommonSetTextFieldEnable(self.sideDish7TextField, placeholderText: "")
            self.sideDish7DownPicker = DownPicker(textField: self.sideDish7TextField, withData:BusinessGroupArray.sideDish as! [Any])
            self.sideDish7DownPicker.setPlaceholder("선택하세요.")
            self.sideDish7DownPicker.setToolbarCancelButtonText("취소")
            self.sideDish7DownPicker.setToolbarDoneButtonText("완료")

            UICommonSetLabel(self.dessert1Label, text: "후식", color: 0)
            UICommonSetTextFieldEnable(self.dessert1TextField, placeholderText: "")
            self.dessert1DownPicker = DownPicker(textField: self.dessert1TextField, withData:BusinessGroupArray.dessert as! [Any])
            self.dessert1DownPicker.setPlaceholder("선택하세요.")
            self.dessert1DownPicker.setToolbarCancelButtonText("취소")
            self.dessert1DownPicker.setToolbarDoneButtonText("완료")

            UICommonSetLabel(self.dessert2Label, text: "후식", color: 0)
            UICommonSetTextFieldEnable(self.dessert2TextField, placeholderText: "")
            self.dessert2DownPicker = DownPicker(textField: self.dessert2TextField, withData:BusinessGroupArray.dessert as! [Any])
            self.dessert2DownPicker.setPlaceholder("선택하세요.")
            self.dessert2DownPicker.setToolbarCancelButtonText("취소")
            self.dessert2DownPicker.setToolbarDoneButtonText("완료")

            UICommonSetLabel(self.dessert3Label, text: "후식", color: 0)
            UICommonSetTextFieldEnable(self.dessert3TextField, placeholderText: "")
            self.dessert3DownPicker = DownPicker(textField: self.dessert3TextField, withData:BusinessGroupArray.dessert as! [Any])
            self.dessert3DownPicker.setPlaceholder("선택하세요.")
            self.dessert3DownPicker.setToolbarCancelButtonText("취소")
            self.dessert3DownPicker.setToolbarDoneButtonText("완료")

            UICommonSetLabel(self.remarksLabel, text: "비고", color: 0)
            UICommonSetTextViewEnable(self.remarksTextView, placeholderText: "")
        } else {
            UICommonSetLabel(self.dateLabel, text: "일자", color: 0)
            UICommonSetTextFieldDisable(self.dateTextField)
            
            UICommonSetLabel(self.locationLabel, text: "위치", color: 0)
            UICommonSetTextFieldDisable(self.locationTextField)
            
            UICommonSetLabel(self.divisionLabel, text: "구분", color: 0)
            UICommonSetTextFieldDisable(self.divisionTextField)
            
            UICommonSetLabel(self.stapleFood1Label, text: "주식(밥,면)", color: 0)
            UICommonSetTextFieldDisable(self.stapleFood1TextField)
            
            UICommonSetLabel(self.soup1Label, text: "국", color: 0)
            UICommonSetTextFieldDisable(self.soup1TextField)
            
            UICommonSetLabel(self.sideDish1Label, text: "반찬", color: 0)
            UICommonSetTextFieldDisable(self.sideDish1TextField)
            
            UICommonSetLabel(self.sideDish2Label, text: "반찬", color: 0)
            UICommonSetTextFieldDisable(self.sideDish2TextField)
            
            UICommonSetLabel(self.sideDish3Label, text: "반찬", color: 0)
            UICommonSetTextFieldDisable(self.sideDish3TextField)
            
            UICommonSetLabel(self.sideDish4Label, text: "반찬", color: 0)
            UICommonSetTextFieldDisable(self.sideDish4TextField)

            UICommonSetLabel(self.sideDish5Label, text: "반찬", color: 0)
            UICommonSetTextFieldDisable(self.sideDish5TextField)

            UICommonSetLabel(self.sideDish6Label, text: "반찬", color: 0)
            UICommonSetTextFieldDisable(self.sideDish6TextField)

            UICommonSetLabel(self.sideDish7Label, text: "반찬", color: 0)
            UICommonSetTextFieldDisable(self.sideDish7TextField)

            UICommonSetLabel(self.dessert1Label, text: "후식", color: 0)
            UICommonSetTextFieldDisable(self.dessert1TextField)

            UICommonSetLabel(self.dessert2Label, text: "후식", color: 0)
            UICommonSetTextFieldDisable(self.dessert2TextField)
            
            UICommonSetLabel(self.dessert3Label, text: "후식", color: 0)
            UICommonSetTextFieldDisable(self.dessert3TextField)

            UICommonSetLabel(self.remarksLabel, text: "비고", color: 0)
            UICommonSetTextViewDisable(self.remarksTextView)
        }
        
        self.contentView.addSubview(self.dateLabel)
        self.contentView.addSubview(self.dateTextField)
        self.contentView.addSubview(self.locationLabel)
        self.contentView.addSubview(self.locationTextField)
        self.contentView.addSubview(self.divisionLabel)
        self.contentView.addSubview(self.divisionTextField)
        self.contentView.addSubview(self.stapleFood1Label)
        self.contentView.addSubview(self.stapleFood1TextField)
        self.contentView.addSubview(self.soup1Label)
        self.contentView.addSubview(self.soup1TextField)
        self.contentView.addSubview(self.sideDish1Label)
        self.contentView.addSubview(self.sideDish1TextField)
        self.contentView.addSubview(self.sideDish2Label)
        self.contentView.addSubview(self.sideDish2TextField)
        self.contentView.addSubview(self.sideDish3Label)
        self.contentView.addSubview(self.sideDish3TextField)
        self.contentView.addSubview(self.sideDish4Label)
        self.contentView.addSubview(self.sideDish4TextField)
        self.contentView.addSubview(self.sideDish5Label)
        self.contentView.addSubview(self.sideDish5TextField)
        self.contentView.addSubview(self.sideDish6Label)
        self.contentView.addSubview(self.sideDish6TextField)
        self.contentView.addSubview(self.sideDish7Label)
        self.contentView.addSubview(self.sideDish7TextField)
        self.contentView.addSubview(self.dessert1Label)
        self.contentView.addSubview(self.dessert1TextField)
        self.contentView.addSubview(self.dessert2Label)
        self.contentView.addSubview(self.dessert2TextField)
        self.contentView.addSubview(self.dessert3Label)
        self.contentView.addSubview(self.dessert3TextField)
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
        self.stapleFood1TextField.text = meal.stapleFood1
        self.soup1TextField.text = meal.soup1
        self.sideDish1TextField.text = meal.sideDish1
        self.sideDish2TextField.text = meal.sideDish2
        self.sideDish3TextField.text = meal.sideDish3
        self.sideDish4TextField.text = meal.sideDish4
        self.sideDish5TextField.text = meal.sideDish5
        self.sideDish6TextField.text = meal.sideDish6
        self.sideDish7TextField.text = meal.sideDish7
        self.dessert1TextField.text = meal.dessert1
        self.dessert2TextField.text = meal.dessert2
        self.dessert3TextField.text = meal.dessert3
        
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
                              stapleFood1: "",
                              soup1: "",
                              sideDish1: "",
                              sideDish2: "",
                              sideDish3: "",
                              sideDish4: "",
                              sideDish5: "",
                              sideDish6: "",
                              sideDish7: "",
                              dessert1: "",
                              dessert2: "",
                              dessert3: "",
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
                              stapleFood1: self.stapleFood1TextField.text!,
                              soup1: self.soup1TextField.text!,
                              sideDish1: self.sideDish1TextField.text!,
                              sideDish2: self.sideDish2TextField.text!,
                              sideDish3: self.sideDish3TextField.text!,
                              sideDish4: self.sideDish4TextField.text!,
                              sideDish5: self.sideDish5TextField.text!,
                              sideDish6: self.sideDish6TextField.text!,
                              sideDish7: self.sideDish7TextField.text!,
                              dessert1: self.dessert1TextField.text!,
                              dessert2: self.dessert2TextField.text!,
                              dessert3: self.dessert3TextField.text!,
                              remarks: self.remarksTextView.text!))
        return ""
    }

    
    //MARK: Size
    class func height() -> CGFloat {
        var height: CGFloat = 0

        //TextField 15개
        //TextView  1개
        height += Metric.commonOffset * 16
        height += Metric.commonHeight * 15
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
        
        //주식(밥,면)1
        self.stapleFood1Label.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.divisionLabel.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.stapleFood1TextField.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.divisionLabel.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        
        //국1
        self.soup1Label.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.stapleFood1Label.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.soup1TextField.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.stapleFood1Label.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }

        //반찬1
        self.sideDish1Label.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.soup1Label.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.sideDish1TextField.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.soup1Label.snp.bottom).offset(Metric.commonOffset)
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

        //반찬5
        self.sideDish5Label.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.sideDish4Label.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.sideDish5TextField.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.sideDish4Label.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }

        //반찬6
        self.sideDish6Label.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.sideDish5Label.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.sideDish6TextField.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.sideDish5Label.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }

        //반찬7
        self.sideDish7Label.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.sideDish6Label.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.sideDish7TextField.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.sideDish6Label.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        
        //후식1
        self.dessert1Label.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.sideDish7Label.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.dessert1TextField.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.sideDish7Label.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }

        //후식2
        self.dessert2Label.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.dessert1Label.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.dessert2TextField.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.dessert1Label.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }

        //후식3
        self.dessert3Label.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.dessert2Label.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.dessert3TextField.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.dessert2Label.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }

        //비고
        self.remarksLabel.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.dessert3Label.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.remarksTextView.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.dessert3Label.snp.bottom).offset(Metric.commonOffset)
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
