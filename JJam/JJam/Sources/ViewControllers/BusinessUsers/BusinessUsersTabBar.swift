//
//  BusinessUsersTabBar.swift
//  JJam
//
//  Created by admin on 2017. 7. 18..
//  Copyright © 2017년 admin. All rights reserved.
//


import UIKit

final class BusinessUsersTabBar: UITabBarController {
    //ViewControllers
    let businessUsersMealList = BusinessUsersMealList(businessUsersRestaurantId: "1")           //업체 ID
    let businessUsersMenuManagement = BusinessUsersMenuManagement(segmentedIndexAndCode: 0)     //메뉴 관리
    //let businessUsersStapleFood = BusinessUsersStapleFood()
    //let businessUsersSoup = BusinessUsersSoup()
    //let businessUsersSideDish = BusinessUsersSideDish()
    //let businessUsersDessert = BusinessUsersDessert()
    let businessUsersSettings = BusinessUsersSettings()                                         //설정
    
    init(selectIndex: Int) {
        super.init(nibName: nil, bundle: nil)
        //self.delegate = self
        self.viewControllers = [
            UINavigationController(rootViewController: self.businessUsersMealList),
            UINavigationController(rootViewController: self.businessUsersMenuManagement),
            //UINavigationController(rootViewController: self.businessUsersStapleFood),
            //UINavigationController(rootViewController: self.businessUsersSoup),
            //UINavigationController(rootViewController: self.businessUsersSideDish),
            //UINavigationController(rootViewController: self.businessUsersDessert),
            UINavigationController(rootViewController: self.businessUsersSettings),
        ]
        
        self.selectedIndex = selectIndex;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

