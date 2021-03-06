//
//  RestaurantListSearchCell.swift
//  JJam
//
//  Created by admin on 2017. 7. 18..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

final class RestaurantListSearchCell: UITableViewCell {
    //MARK: init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: configure
    func configure(restaurantSearch: RestaurantSearch) {
        self.backgroundColor = .white
        self.detailTextLabel?.numberOfLines = 0     //multiple lines
        
        self.textLabel?.text = restaurantSearch.companyName

        var certification: String!
        //certification = "(사업자 등록증 인증 업체)"
        
        if restaurantSearch.certification == "y" {
            self.textLabel?.textColor = .blue
            certification = "(사업자 등록증 인증 업체)"
        } else {
            certification = "(사업자 등록증 미인증 업체)"
            self.textLabel?.textColor = .red
        }
        self.detailTextLabel?.text = certification + "\n"
                                    + "주소 : " + restaurantSearch.address.replacingOccurrences(of: "\n", with: " ") + "\n"
                                    + "연락처 : " + restaurantSearch.contactNumber + "\n"
                                    + "대표 : " + restaurantSearch.representative
        
        if restaurantSearch.isDone {
            self.accessoryType = .checkmark
        } else {
            self.accessoryType = .none
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
