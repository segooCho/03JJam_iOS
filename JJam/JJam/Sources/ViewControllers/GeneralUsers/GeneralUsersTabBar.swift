//
//  GeneralUsersTabBar.swift
//  JJam
//
//  Created by admin on 2017. 7. 18..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

final class GeneralUsersTabBar: UITabBarController {
    //ViewControllers
    fileprivate let interestRestaurantList = InterestRestaurantList()
    fileprivate let board = Board(title :"식당 요청, 문의 게시판", restaurant_Id :"")
    fileprivate let generalUsersSettings = GeneralUsersSettings()
    
    init(selectIndex: Int) {
        super.init(nibName: nil, bundle: nil)
        //self.delegate = self
        self.viewControllers = [
            UINavigationController(rootViewController: self.interestRestaurantList),
            UINavigationController(rootViewController: self.board),
            UINavigationController(rootViewController: self.generalUsersSettings),
        ]
        self.selectedIndex = selectIndex;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

