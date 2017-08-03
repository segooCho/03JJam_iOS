//
//  BusinessUsersMenuCell.swift
//  JJam
//
//  Created by admin on 2017. 7. 19..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

final class BusinessUsersMenuCell: UITableViewCell {
    //MARK: init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: configure
    func configure(group: Group) {
        self.backgroundColor = .white
        
        self.textLabel?.text = group.text

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}

