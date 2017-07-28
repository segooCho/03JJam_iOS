//
//  UIImageViewSetImage.swift
//  JJam
//
//  Created by admin on 2017. 7. 26..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

func imageViewBorder(_ uIKit: UIImageView, view: UIView) {
    uIKit.layer.frame = (view.layer.frame).insetBy(dx: 0, dy: 0)
    uIKit.layer.borderWidth = 0.5
    uIKit.layer.borderColor = UIColor.gray.cgColor
    uIKit.layer.cornerRadius = (view.frame.height)/5
    uIKit.layer.masksToBounds = false
    uIKit.clipsToBounds = true
    uIKit.contentMode = UIViewContentMode.scaleAspectFill
}

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

