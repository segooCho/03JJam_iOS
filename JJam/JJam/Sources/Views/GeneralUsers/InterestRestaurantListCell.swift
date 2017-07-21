//
//  InterestRestaurantListCell.swift
//  JJam
//
//  Created by admin on 2017. 7. 12..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

final class InterestRestaurantListCell: UITableViewCell {
    //MARK: init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: configure
    func configure(interestRestaurant: InterestRestaurant) {
        self.backgroundColor = .white
        self.textLabel?.text = interestRestaurant.companyName
        self.detailTextLabel?.text = interestRestaurant.address
        self.accessoryType = .disclosureIndicator
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}