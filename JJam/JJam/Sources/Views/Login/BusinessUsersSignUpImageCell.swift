//
//  BusinessUsersSignUpImageCell.swift
//  JJam
//
//  Created by admin on 2017. 7. 20..
//  Copyright © 2017년 admin. All rights reserved.
//


import UIKit

final class BusinessUsersSignUpImageCell: UITableViewCell {
    //MARK: Properties
    /*
    struct signUp {
        static var photoView: String = ""
    }
    */
    
    //MARK: Constants
    fileprivate struct Metric {
        static let labelLeft = CGFloat(10)
        static let labelRight = CGFloat(-250)
        
        static let imageLeft = CGFloat(130)
        static let imageRight = CGFloat(-10)

        
        static let commonOffset = CGFloat(7)
        static let commonHeight = CGFloat(45)
        static let commonHeightImageView = CGFloat(230)
    }

    //MARK: UI
    fileprivate let contentViewButton = UIButton()                                      //cell 선택시 반전 방지용 뷰
    fileprivate let label = UILabel()
    fileprivate let photoView = UIImageView()                                           //포토 뷰
    
    //MARK: init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        //contentViewButton 반전 방지용 뷰 - 아무 설정하지 않음
        self.contentView.addSubview(self.contentViewButton)

        UICommonSetLabel(self.label, text: "사업자 등록증", color: 0)
        self.contentViewButton.addSubview(self.label)
        

        //self.photoView.backgroundColor = .red
        //image 라운드
        imageViewBorder(self.photoView, view: self)
        
        
        self.contentViewButton.addSubview(self.photoView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: configure
    func configure(image: UIImage) {
        self.photoView.image = image
    }
    
    //MARK: Size
    class func height(width: CGFloat) -> CGFloat {
        var height: CGFloat = 0
        
        height += Metric.commonOffset*2                             //상단 여백
        height += Metric.commonHeightImageView
        height += Metric.commonOffset                               //하단 여백
        return height
        //return width // 정사각형
    }
    
    //MARK: Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        //임시 영역 처리
        self.contentViewButton.frame = self.contentView.bounds
        //사업자 등록증
        self.label.snp.makeConstraints { make in
            make.left.equalTo(Metric.labelLeft)
            make.right.equalTo(Metric.labelRight)
            make.top.equalTo(self.contentViewButton.snp.top).offset(Metric.commonOffset)
            make.height.equalTo(Metric.commonHeight)
        }
        //사진 이미지
        self.photoView.snp.makeConstraints { make in
            make.left.equalTo(Metric.imageLeft)
            make.right.equalTo(Metric.imageRight)
            make.top.equalTo(self.contentViewButton.snp.top).offset(Metric.commonOffset*2)
            make.height.equalTo(Metric.commonHeightImageView)
        }
    }
}


