//
//  MealListCell.swift
//  JJam
//
//  Created by admin on 2017. 7. 15..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

final class MealListCell: UITableViewCell {
    //MARK: init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: configure
    func configure(meal: Meal) {
        self.backgroundColor = .white
       
        //image
        //self.imageView?.image = UIImage(named: meal.foodImage)
        self.imageView!.setImage(with: meal.foodImage)
        
        //TODO :: image 사이즈 고정 && image 라운드 재정리 필요
        //image 사이즈 고정
        let itemSize = CGSize(width:42.0, height:42.0)
        UIGraphicsBeginImageContextWithOptions(itemSize, false, 0.0)
        let imageRect = CGRect(x:0.0, y:0.0, width:itemSize.width, height:itemSize.height)
        self.imageView!.image?.draw(in:imageRect)
        self.imageView!.image? = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        //image 라운드
        self.imageView!.layer.frame = (self.layer.frame).insetBy(dx: 0, dy: 0)
        self.imageView!.layer.borderWidth = 0.5
        self.imageView!.layer.borderColor = UIColor.gray.cgColor
        self.imageView!.layer.cornerRadius = (self.frame.height)/5
        self.imageView!.layer.masksToBounds = false
        self.imageView!.clipsToBounds = true
        self.imageView!.contentMode = UIViewContentMode.scaleAspectFill
 
        //일자
        self.textLabel!.text = meal.mealDate + " (" + meal.mealDateLabel + ") " + meal.division
        
        //요약 내용
        self.detailTextLabel!.text = meal.stapleFood + "," + meal.soup + "," + meal.sideDish1 + "," + meal.sideDish2 + ","
                                    + meal.sideDish3 + "," + meal.sideDish4 + "," + meal.dessert
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

