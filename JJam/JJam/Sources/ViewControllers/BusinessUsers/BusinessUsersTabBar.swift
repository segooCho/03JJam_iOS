//
//  BusinessUsersTabBar.swift
//  JJam
//
//  Created by admin on 2017. 7. 18..
//  Copyright © 2017년 admin. All rights reserved.
//


import UIKit

final class BusinessUsersTabBar: UITabBarController {
    public var _id:String!
    
    //ViewControllers
    let businessUsersMealList = BusinessUsersMealList(_id: "")           //업체 ID
    let businessUsersMenuManagement = BusinessUsersMenuManagement(_id: "", segmentedIndexAndCode: 0)     //메뉴 관리
    //let businessUsersStapleFood = BusinessUsersStapleFood()
    //let businessUsersSoup = BusinessUsersSoup()
    //let businessUsersSideDish = BusinessUsersSideDish()
    //let businessUsersDessert = BusinessUsersDessert()
    let businessUsersSettings = BusinessUsersSettings(_id: "")                                         //설정
    
    init(_id : String, selectIndex: Int) {
        self._id = _id;
        super.init(nibName: nil, bundle: nil)
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

