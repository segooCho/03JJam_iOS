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

//이미지 사이즈 조정
func setImageSize(_ image: UIImage, size: Int) -> UIImage{
    var tmpImage = image
    var imageSize: CGFloat = 0
    
    switch size {
    case 0:
        imageSize = SuperConstants.tableViewImageSize
    default:
        imageSize = SuperConstants.imageSize
    }
    
    let itemSize = CGSize(width:imageSize, height:imageSize)
    UIGraphicsBeginImageContextWithOptions(itemSize, false, 0.0)
    let imageRect = CGRect(x:0.0, y:0.0, width:itemSize.width, height:itemSize.height)
    tmpImage.draw(in:imageRect)
    tmpImage = UIGraphicsGetImageFromCurrentImageContext()!;
    UIGraphicsEndImageContext();
    return tmpImage
}

extension UIImageView {
    func setImage(with foodImage: String?) {
        if let foodImage = foodImage {
            let url = URL(string: Url.uploads + "/\(foodImage)")
            
            self.kf.setImage(with: url, placeholder: UIImage(named: "NoImageFound.jpg"))
        }else {
            self.kf.setImage(with: nil)
        }
    }
}

