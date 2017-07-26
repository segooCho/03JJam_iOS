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
        
        //self.contentView.addSubview(self.photoView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: configure
    func configure(foodImage: String) {
        self.photoView.setImage(with: foodImage)
        //self.photoView.image = UIImage(named: foodImage)
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
        
        /*
        self.scrollView.contentInset.top = self.scrollView.snp_height / 2 - self.cropAreaView.height / 2
        self.scrollView.contentInset.bottom = self.scrollView.contentInset.top
        self.scrollView.contentSize = self.photoView.size
        self.scrollView.contentOffset.x = self.scrollView.contentSize.width / 2 - self.scrollView.width / 2
        self.scrollView.contentOffset.y = self.scrollView.contentSize.height / 2 - self.scrollView.height / 2
        */

    }
}

extension MealDetailImageCell: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.photoView
    }
}

