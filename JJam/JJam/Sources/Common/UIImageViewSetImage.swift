//
//  UIImageViewSetImage.swift
//  JJam
//
//  Created by admin on 2017. 7. 26..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImage(with foodImage: String?) {
        if let foodImage = foodImage {
            let url = URL(string: FixedCommonSet.networkinkBaseUrl + "uploads/\(foodImage)")
            self.kf.setImage(with: url, placeholder: UIImage(named: "NoImageFound.jpg"))
        }else {
            self.kf.setImage(with: nil)
        }
    }
    
    
}

