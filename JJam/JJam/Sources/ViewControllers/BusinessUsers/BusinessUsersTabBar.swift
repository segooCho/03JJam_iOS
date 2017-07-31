//
//  BusinessUsersTabBar.swift
//  JJam
//
//  Created by admin on 2017. 7. 18..
//  Copyright © 2017년 admin. All rights reserved.
//


import UIKit

final class BusinessUsersTabBar: UITabBarController {
    
    init(_id: String, selectIndex: Int) {
        super.init(nibName: nil, bundle: nil)
        
        //ViewControllers 생성 작업을 _id 값을 필수 작업이어서 내부에서 진행 한다.
        let businessUsersMealList = BusinessUsersMealList(_id: _id)                                          //업체 ID
        let businessUsersMenuManagement = BusinessUsersMenuManagement(_id: _id, segmentedIndexAndCode: 0)    //메뉴 관리
        let businessUsersSettings = BusinessUsersSettings(_id: _id)                                          //설정

        self.viewControllers = [
            UINavigationController(rootViewController: businessUsersMealList),
            UINavigationController(rootViewController: businessUsersMenuManagement),
            UINavigationController(rootViewController: businessUsersSettings),
        ]
        self.selectedIndex = selectIndex;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
