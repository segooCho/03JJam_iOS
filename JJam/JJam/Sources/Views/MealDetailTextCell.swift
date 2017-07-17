//
//  MealDetailTextCell.swift
//  JJam
//
//  Created by admin on 2017. 7. 17..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

final class MealDetailTextCell: UITableViewCell {
    //MARK: Constants
    fileprivate struct Metric {
        static let labelLeft = CGFloat(10)
        static let labelRight = CGFloat(-300)

        static let textFieldLeft = CGFloat(80)
        static let textFieldRight = CGFloat(-10)
        
        static let commonOffset = CGFloat(5)
        static let commonHeight = CGFloat(30)
        static let commonHeightTextView = CGFloat(100)
    }
    
    fileprivate struct Font {
        static let label = UIFont.systemFont(ofSize: 14)
        static let TextField = UIFont.systemFont(ofSize: 14)
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
        
        let color = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0).cgColor
        //self.dateLabel.backgroundColor = .red
        self.dateLabel.font = Font.label
        self.dateLabel.text = "일자"
        self.dateTextField.layer.borderColor = color
        self.dateTextField.layer.borderWidth = 0.5
        self.dateTextField.layer.cornerRadius = 5
        self.dateTextField.font = Font.TextField
        self.dateTextField.isEnabled = false
        
        self.divisionLabel.font = Font.label
        self.divisionLabel.text = "구분"
        self.divisionTextField.layer.borderColor = color
        self.divisionTextField.layer.borderWidth = 0.5
        self.divisionTextField.layer.cornerRadius = 5
        self.divisionTextField.font = Font.TextField
        self.divisionTextField.isEnabled = false
        
        self.stapleFoodLabel.font = Font.label
        self.stapleFoodLabel.text = "주식"
        self.stapleFoodTextField.layer.borderColor = color
        self.stapleFoodTextField.layer.borderWidth = 0.5
        self.stapleFoodTextField.layer.cornerRadius = 5
        self.stapleFoodTextField.font = Font.TextField
        self.stapleFoodTextField.isEnabled = false
        
        self.soupLabel.font = Font.label
        self.soupLabel.text = "국"
        self.soupTextField.layer.borderColor = color
        self.soupTextField.layer.borderWidth = 0.5
        self.soupTextField.layer.cornerRadius = 5
        self.soupTextField.font = Font.TextField
        self.soupTextField.isEnabled = false

        self.sideDish1Label.font = Font.label
        self.sideDish1Label.text = "반찬1"
        self.sideDish1TextField.layer.borderColor = color
        self.sideDish1TextField.layer.borderWidth = 0.5
        self.sideDish1TextField.layer.cornerRadius = 5
        self.sideDish1TextField.font = Font.TextField
        self.sideDish1TextField.isEnabled = false

        self.sideDish2Label.font = Font.label
        self.sideDish2Label.text = "반찬2"
        self.sideDish2TextField.layer.borderColor = color
        self.sideDish2TextField.layer.borderWidth = 0.5
        self.sideDish2TextField.layer.cornerRadius = 5
        self.sideDish2TextField.font = Font.TextField
        self.sideDish2TextField.isEnabled = false

        self.sideDish3Label.font = Font.label
        self.sideDish3Label.text = "반찬3"
        self.sideDish3TextField.layer.borderColor = color
        self.sideDish3TextField.layer.borderWidth = 0.5
        self.sideDish3TextField.layer.cornerRadius = 5
        self.sideDish3TextField.font = Font.TextField
        self.sideDish3TextField.isEnabled = false
        
        self.sideDish4Label.font = Font.label
        self.sideDish4Label.text = "반찬4"
        self.sideDish4TextField.layer.borderColor = color
        self.sideDish4TextField.layer.borderWidth = 0.5
        self.sideDish4TextField.layer.cornerRadius = 5
        self.sideDish4TextField.font = Font.TextField
        self.sideDish4TextField.isEnabled = false
        
        self.dessertLabel.font = Font.label
        self.dessertLabel.text = "후식"
        self.dessertTextField.layer.borderColor = color
        self.dessertTextField.layer.borderWidth = 0.5
        self.dessertTextField.layer.cornerRadius = 5
        self.dessertTextField.font = Font.TextField
        self.dessertTextField.isEnabled = false

        self.remarksLabel.font = Font.label
        self.remarksLabel.text = "비고"
        self.remarksTextView.layer.borderColor = color
        self.remarksTextView.layer.borderWidth = 0.5
        self.remarksTextView.layer.cornerRadius = 5
        self.remarksTextView.font = Font.TextField
        self.remarksTextView.isEditable = false

        
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
    
    //MARK : configure
    func configure(detail: Detail) {
        self.dateTextField.text = detail.dateString
        self.divisionTextField.text = detail.division
        self.stapleFoodTextField.text = detail.stapleFood
        self.soupTextField.text = detail.soup
        self.sideDish1TextField.text = detail.sideDish1
        self.sideDish2TextField.text = detail.sideDish2
        self.sideDish3TextField.text = detail.sideDish3
        self.sideDish4TextField.text = detail.sideDish4
        self.dessertTextField.text = detail.dessert
        self.remarksTextView.text = detail.remarks
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
        
        //주식
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
