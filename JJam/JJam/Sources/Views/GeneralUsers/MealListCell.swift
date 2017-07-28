//
//  MealListCell.swift
//  JJam
//
//  Created by admin on 2017. 7. 15..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

final class MealListCell: UITableViewCell {
    fileprivate var segmentedIndexAndCode = 0
    
    //MARK: init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: configure
    func configure(meal: Meal, segmentedIndexAndCode: Int) {
        self.segmentedIndexAndCode = segmentedIndexAndCode
        self.backgroundColor = .white
       
        //image
        //self.imageView?.image = UIImage(named: meal.foodImage)
        self.imageView!.setImage(with: meal.foodImage)
        
        //TODO :: image 사이즈 고정 && image 라운드 재정리 필요
        //image 사이즈 고정
        let itemSize = CGSize(width:57.0, height:57.0)
        UIGraphicsBeginImageContextWithOptions(itemSize, false, 0.0)
        let imageRect = CGRect(x:0.0, y:0.0, width:itemSize.width, height:itemSize.height)
        self.imageView!.image?.draw(in:imageRect)
        self.imageView!.image? = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //image 라운드
        imageViewBorder(self.imageView!, view: self)
        /*
        self.imageView!.layer.frame = (self.layer.frame).insetBy(dx: 0, dy: 0)
        self.imageView!.layer.borderWidth = 0.5
        self.imageView!.layer.borderColor = UIColor.gray.cgColor
        self.imageView!.layer.cornerRadius = (self.frame.height)/5
        self.imageView!.layer.masksToBounds = false
        self.imageView!.clipsToBounds = true
        self.imageView!.contentMode = UIViewContentMode.scaleAspectFill
        */
 
        
        self.detailTextLabel!.numberOfLines = 3
        //오늘 식단, 계획 식단, 과거 식단 & Image 식단
        switch segmentedIndexAndCode {
        case 3 :
            //Image 식단
            self.textLabel!.text = meal.mealDate + " (" + meal.mealDateLabel + ")"
            //요약 내용
            self.detailTextLabel!.text = ""

        default :
            //오늘 식단, 계획 식단, 과거 식단
            //일자 (요일) 아침,점심,저녁
            self.textLabel!.text = meal.mealDate + " (" + meal.mealDateLabel + ") " + meal.division
            //요약 내용
            self.detailTextLabel!.numberOfLines = 3
            self.detailTextLabel!.text = "위치 : " + meal.location + "\n"
                                       + "메뉴 : " + meal.stapleFood + "," + meal.soup + "," + meal.sideDish1 + ","
                                       + meal.sideDish2 + "," + meal.sideDish3 + "," + meal.sideDish4 + "," + meal.dessert
        }
        
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

