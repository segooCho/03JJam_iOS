//
//  MealListCell.swift
//  JJam
//
//  Created by admin on 2017. 7. 15..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

final class MealListCell: UITableViewCell {
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
    func configure(meal: Meal, segmentedIndexAndCode: Int) {
        self.segmentedIndexAndCode = segmentedIndexAndCode
        self.backgroundColor = .white
       
        //image
        //self.imageView?.image = UIImage(named: meal.foodImage)
        self.imageView!.setImage(with: meal.foodImage, path: 0)
        
        //image 사이즈 조정
        self.imageView?.image = setImageSize((self.imageView?.image)!, size: 0)
        
        //image 라운드
        imageViewBorder(self.imageView!, view: self)
        
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
            
            //메뉴 문자열 처리
            var detailText = "메뉴 : " + meal.stapleFood + "," + meal.soup + "," + meal.sideDish1 + ","
                + meal.sideDish2 + "," + meal.sideDish3 + "," + meal.sideDish4 + "," + meal.dessert + "@"
            detailText = detailText.replacingOccurrences(of: ",,", with: "")
            detailText = detailText.replacingOccurrences(of: ",@", with: "")
            detailText = detailText.replacingOccurrences(of: "@", with: "")
            
            self.detailTextLabel!.text = "위치 : " + meal.location + "\n" + detailText
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

