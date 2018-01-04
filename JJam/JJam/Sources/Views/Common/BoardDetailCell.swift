//
//  BoardDetailCell.swift
//  JJam
//
//  Created by admin on 2018. 1. 3..
//  Copyright © 2018년 admin. All rights reserved.
//

import UIKit
import DownPicker

final class BoardDetailCell: UITableViewCell {
    //MARK: Properties
    struct tableViewCellBoardInfo {
        static var boardCellInfo: [BoardCellInfo] = []
    }
    fileprivate var boardInfo: [BoardInfo] = []
    fileprivate let division: NSMutableArray = ["식당 요청", "문의"]
    fileprivate let businessDivision: NSMutableArray = ["식당 요청"]

    //MARK: Constants
    fileprivate struct Metric {
        static let labelLeft = CGFloat(10)
        static let labelRight = CGFloat(-270)
        
        static let textFieldLeft = CGFloat(120)
        static let textFieldRight = CGFloat(-10)
        
        static let commonOffset = CGFloat(7)
        static let commonHeight = CGFloat(45)
        static let commonHeightTextView = CGFloat(250)
    }
    
    // MARK: UI
    //구분
    fileprivate let divisonLabel = UILabel()
    let divisonTextField = UITextField()
    fileprivate var divisonDownPicker: DownPicker!
    //제목
    fileprivate let titleLabel = UILabel()
    fileprivate let titleTextField = UITextField()
    
    //문의 & 요청
    fileprivate let contentsLabel = UILabel()
    fileprivate let contentsTextView = UITextView()
    
    //답변
    fileprivate let answerLabel = UILabel()
    fileprivate let answerTextView = UITextView()
    
    //MARK: init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: configure
    func configure(boardInfo: [BoardInfo]) {
        self.boardInfo = boardInfo
        
        UICommonSetLabel(self.divisonLabel, text: "구분", color: 1)
        UICommonSetTextFieldEnable(self.divisonTextField, placeholderText: "")

        if self.boardInfo[0].restaurant_Id == "" {
            self.divisonDownPicker = DownPicker(textField: self.divisonTextField, withData:division as! [Any])
            self.divisonTextField.text = "식당 요청"
            self.divisonTextField.isEnabled = true
            self.divisonDownPicker.addTarget(self, action: #selector(textFieldValueChangeText), for: .valueChanged)
            self.contentsTextView.text = "주소 : \n\n상호 : \n\n연락처 : \n"
        } else {
            self.divisonTextField.text = "문의"
            self.divisonTextField.isEnabled = false
            self.contentsTextView.text = ""
        }
        
        UICommonSetLabel(self.titleLabel, text: "제목", color: 1)
        UICommonSetTextFieldEnable(self.titleTextField, placeholderText: "")
        UICommonSetLabel(self.contentsLabel, text: "문의/요청", color: 1)
        UICommonSetTextViewEnable(self.contentsTextView, placeholderText: "")
        UICommonSetLabel(self.answerLabel, text: "답변", color: 0)
        UICommonSetTextViewEnable(self.answerTextView, placeholderText: "")

        self.contentView.addSubview(self.divisonLabel)
        self.contentView.addSubview(self.divisonTextField)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.titleTextField)
        self.contentView.addSubview(self.contentsLabel)
        self.contentView.addSubview(self.contentsTextView)
        self.contentView.addSubview(self.answerLabel)
        self.contentView.addSubview(self.answerTextView)
        
        if self.boardInfo[0].board_Id != nil {
            self.divisonTextField.text = self.boardInfo[0].division
            self.titleTextField.text = self.boardInfo[0].title
            self.contentsTextView.text = self.boardInfo[0].contents
            self.answerTextView.text = self.boardInfo[0].answer
            self.divisonTextField.isEnabled = false
            self.titleTextField.isEnabled = false
        } else {
            self.divisonTextField.isEnabled = true
            self.titleTextField.isEnabled = true
        }
        
        if self.boardInfo[0].answer != "" {
            self.contentsTextView.isEditable = false
        }
        self.answerTextView.isEditable = false
        self.setNeedsLayout()
    }
    
    func textFieldValueChangeText(_ textField: UITextField) {
        if self.boardInfo[0].board_Id == nil {
            if self.divisonTextField.text == "식당 요청" {
                self.contentsTextView.text = "주소 : \n\n상호 : \n\n연락처 : \n"
            } else {
                self.contentsTextView.text = ""
            }
        }
    }

    
    //MealDetailTextCell에서 struct의 값을 접근하기 전에 값을 셋팅힌다.
    func setInputData() -> String {
        tableViewCellBoardInfo.boardCellInfo.removeAll()
        tableViewCellBoardInfo.boardCellInfo.append(
            BoardCellInfo(board_Id: ""
                        , restaurant_Id: ""
                        , uniqueId: ""
                        , division: ""
                        , title: ""
                        , contents: ""
                        , answer: ""
                        , message: ""))
        
        var inputText = ""
        inputText = self.divisonTextField.text!
        if inputText.isEmpty {
            self.divisonTextField.becomeFirstResponder()
            return "구분을 선택하세요."
        }
        inputText = self.titleTextField.text!
        if inputText.isEmpty {
            self.titleTextField.becomeFirstResponder()
            return "제목을 입력하세요."
        }
        inputText = self.contentsTextView.text!
        if inputText.isEmpty {
            self.contentsTextView.becomeFirstResponder()
            return "문의/요청 입력하세요."
        }
        
        var tmpBoard_Id = ""
        if self.boardInfo[0].board_Id != nil {
            tmpBoard_Id = self.boardInfo[0].board_Id
        }
        
        tableViewCellBoardInfo.boardCellInfo.removeAll()
        tableViewCellBoardInfo.boardCellInfo.append(
            BoardCellInfo(board_Id: tmpBoard_Id
                        , restaurant_Id: self.boardInfo[0].restaurant_Id
                        , uniqueId: self.boardInfo[0].uniqueId
                        , division: self.divisonTextField.text!
                        , title: self.titleTextField.text!
                        , contents: self.contentsTextView.text!
                        , answer: self.boardInfo[0].answer
                        , message: ""))
        return ""
    }
    
    //MARK: Size
    class func height() -> CGFloat {
        var height: CGFloat = 0
        //TextField 2개
        //TextView  2개
        height += Metric.commonOffset * 3
        height += Metric.commonHeight * 2
        height += Metric.commonHeightTextView * 2
        height += Metric.commonOffset * 2  //하단 여백 처리
        return height
    }
    //MARK: Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        //구분
        self.divisonLabel.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.contentView.snp.top).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.divisonTextField.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.contentView.snp.top).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        
        //제목
        self.titleLabel.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.divisonLabel.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.titleTextField.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.divisonLabel.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        
        //문의/요청
        self.contentsLabel.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.contentsTextView.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeightTextView)
        }
        
        //답변
        self.answerLabel.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.contentsTextView.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.answerTextView.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.contentsTextView.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeightTextView)
        }
    }
}
