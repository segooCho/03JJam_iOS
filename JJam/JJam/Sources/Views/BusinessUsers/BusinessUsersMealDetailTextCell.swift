//
//  BusinessUsersMealDetailTextCell.swift
//  JJam
//
//  Created by admin on 2017. 7. 19..
//  Copyright © 2017년 admin. All rights reserved.
//


import UIKit

final class BusinessUsersMealDetailTextCell: UITableViewCell {
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
    //구분
    fileprivate let divisionLabel = UILabel()
    fileprivate let divisionTextField = UITextField()
    //주식
    fileprivate let stapleFoodLabel = UILabel()
    fileprivate let stapleFoodTextField = UITextField()
    //국
    fileprivate let soupLabel = UILabel()
    fileprivate let soupTextField = UITextField()
    //반찬1
    fileprivate let sideDish1Label = UILabel()
    fileprivate let sideDish1TextField = UITextField()
    //반찬2
    fileprivate let sideDish2Label = UILabel()
    fileprivate let sideDish2TextField = UITextField()
    //반찬3
    fileprivate let sideDish3Label = UILabel()
    fileprivate let sideDish3TextField = UITextField()
    //반찬4
    fileprivate let sideDish4Label = UILabel()
    fileprivate let sideDish4TextField = UITextField()
    //후식
    fileprivate let dessertLabel = UILabel()
    fileprivate let dessertTextField = UITextField()
    //비고
    fileprivate let remarksLabel = UILabel()
    fileprivate let remarksTextView = UITextView()
    
    
    //MARK: init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        //TODO :: SelectBox 처리
        UICommonSetLabel(self.dateLabel, text: "일자", color: 1)
        UICommonSetTextFieldDisable(self.dateTextField)
        
        UICommonSetLabel(self.divisionLabel, text: "구분", color: 1)
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
        
        self.contentView.addSubview(self.dateLabel)
        self.contentView.addSubview(self.dateTextField)
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: configure
    func configure(businessUsersDetail: BusinessUsersDetail) {
        self.dateTextField.text = businessUsersDetail.dateString
        self.divisionTextField.text = businessUsersDetail.division
        self.stapleFoodTextField.text = businessUsersDetail.stapleFood
        self.soupTextField.text = businessUsersDetail.soup
        self.sideDish1TextField.text = businessUsersDetail.sideDish1
        self.sideDish2TextField.text = businessUsersDetail.sideDish2
        self.sideDish3TextField.text = businessUsersDetail.sideDish3
        self.sideDish4TextField.text = businessUsersDetail.sideDish4
        self.dessertTextField.text = businessUsersDetail.dessert
        self.remarksTextView.text = businessUsersDetail.remarks
        self.setNeedsLayout()
    }
    
    //MARK: Size
    class func height() -> CGFloat {
        var height: CGFloat = 0
        
        //TextField 9개
        //TextView  1개
        height += Metric.commonOffset * 10
        height += Metric.commonHeight * 9
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
            make.top.equalTo(self.contentView).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.dateTextField.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.contentView).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        
        //구분
        self.divisionLabel.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.dateLabel.snp.bottom).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        self.divisionTextField.snp.makeConstraints { make in
            make.left.equalTo(Metric.textFieldLeft)
            make.right.equalTo(Metric.textFieldRight)
            make.top.equalTo(self.dateLabel.snp.bottom).offset(Metric.commonOffset)
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
}

