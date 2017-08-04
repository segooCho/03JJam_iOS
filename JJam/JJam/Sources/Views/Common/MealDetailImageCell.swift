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

    //MARK: Constants
    fileprivate struct Metric {
        static let imageSize = CGFloat(100)
    }
    
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
    func configure(editImage: String) {
        self.photoView.setImage(with: editImage, path: 0)
    }
    //MARK: configure
    func configure(image: UIImage) {
        self.photoView.image = image
    }
    
    //MARK: Size
    class func height(width: CGFloat) -> CGFloat {
        return width // 정사각형
    }
    
    //MARK: Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        //ZoomScale 초기화 하지 않으면 다음 Zoom에서 오류가 발생한다.
        self.scrollView.setZoomScale(0, animated: false)
        self.scrollView.frame = self.contentView.bounds
        self.photoView.frame = self.scrollView.bounds
    }
}

extension MealDetailImageCell: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.photoView
    }
}

