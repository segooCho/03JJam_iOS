//
//  BusinessUsersMealListCell.swift
//  JJam
//
//  Created by admin on 2017. 7. 19..
//  Copyright © 2017년 admin. All rights reserved.
//


import UIKit

final class BusinessUsersMealListCell: UITableViewCell {
    //MARK: Properties
    fileprivate var segmentedIndexAndCode = 0
    
    //MARK: Constants
    fileprivate struct Metric {
        static let imageSize = CGFloat(57.0)
    }
    
    //MARK: init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: configure
    func configure(businessUsersMeal: BusinessUsersMeal) {
        self.backgroundColor = .white
        //image
        self.imageView?.image = UIImage(named: businessUsersMeal.imageString)
        
        //TODO :: image 사이즈 고정 && image 라운드 재정리 필요
        //image 사이즈 고정
        let itemSize = CGSize(width:Metric.imageSize, height:Metric.imageSize)
        UIGraphicsBeginImageContextWithOptions(itemSize, false, 0.0)
        let imageRect = CGRect(x:0.0, y:0.0, width:itemSize.width, height:itemSize.height)
        self.imageView?.image!.draw(in:imageRect)
        self.imageView?.image! = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        //image 라운드
        imageViewBorder(self.imageView!, view: self)
        
        //일자
        self.textLabel?.text = businessUsersMeal.dateString
        //요약 내용
        self.detailTextLabel?.text = businessUsersMeal.summary
        self.accessoryType = .disclosureIndicator
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    /*
     override func awakeFromNib() {
     super.awakeFromNib()
     }
     */
}

