//
//  MealDetailImageCell.swift
//  JJam
//
//  Created by admin on 2017. 7. 17..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

final class MealDetailImageCell: UITableViewCell {
    //MARK: UI
    fileprivate let scrollView = UIScrollView()
    fileprivate let photoView = UIImageView()

    //MARK: init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        self.scrollView.delegate = self
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.maximumZoomScale = 3
        self.scrollView.addSubview(self.photoView)
        self.contentView.addSubview(self.scrollView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: configure
    func configure(foodImage: String) {
        self.photoView.setImage(with: foodImage)
    }
    
    //MARK: Size
    class func height(width: CGFloat) -> CGFloat {
        return width // 정사각형
    }
    
    //MARK: Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        self.scrollView.frame = self.contentView.bounds
        self.photoView.frame = self.scrollView.bounds
    }
}

extension MealDetailImageCell: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.photoView
    }
}

