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
    fileprivate let division: NSMutableArray = ["식당 요청", "문의"]

    
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
    fileprivate let divisonTextField = UITextField()
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
    func configure(boardInfo: BoardInfo) {
        
        UICommonSetLabel(self.divisonLabel, text: "구분", color: 1)
        UICommonSetTextFieldEnable(self.divisonTextField, placeholderText: "")
        self.divisonDownPicker = DownPicker(textField: self.divisonTextField, withData:division as! [Any])
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
        
        self.setNeedsLayout()
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
