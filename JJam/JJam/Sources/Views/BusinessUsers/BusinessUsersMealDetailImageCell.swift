//
//  BusinessUsersMealDetailImageCell.swift
//  JJam
//
//  Created by admin on 2017. 7. 19..
//  Copyright © 2017년 admin. All rights reserved.
//


import UIKit

final class BusinessUsersMealDetailImageCell: UITableViewCell {
    //MARK: UI
    fileprivate let photoView = UIImageView()
    
    //MARK: init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.photoView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: configure
    func configure(businessUsersMealDetailImageString: String) {
        self.photoView.image = UIImage(named: businessUsersMealDetailImageString)
    }
    
    //MARK: Size
    class func height(width: CGFloat) -> CGFloat {
        return width // 정사각형
    }
    
    //MARK: Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        self.photoView.frame = self.contentView.bounds
    }
}
