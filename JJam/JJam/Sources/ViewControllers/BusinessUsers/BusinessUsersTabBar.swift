//
//  BusinessUsersTabBar.swift
//  JJam
//
//  Created by admin on 2017. 7. 18..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

final class BusinessUsersTabBar: UITabBarController {
    fileprivate var restaurantGroupUserDefaults:[RestaurantGroupUserDefaults] = []
    // MARK: UI
    fileprivate let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    //MARK: init
    init(_id: String) {
        super.init(nibName: nil, bundle: nil)

        let tempViewController = TempViewController()
        //임시 화면 : 임시 화면 처리용
        self.viewControllers = [
            tempViewController,
        ]
        restaurantCategory(_id: _id)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //식당 category 항목(Group) 조회
    func restaurantCategory(_id: String) {
        //UICommonSetLoadingService(self.activityIndicatorView, service: true)
        BusinessUsersNetWorking.restaurantGroup(_id: _id) { [weak self] response in
            guard let `self` = self else { return }
            if response.count > 0 {
                //TempViewController에서 시작된 것을 종료
                UICommonSetLoadingService(self.activityIndicatorView, service: false)
                let message = response[0].message
                if message != nil {
                    let alertController = UIAlertController(
                        title: "로그인",
                        message: message,
                        preferredStyle: .alert
                    )
                    let alertConfirm = UIAlertAction(
                        title: "로그인 페이지 이동",
                        style: .default) { _ in
                            //확인 후 처리
                            AppDelegate.instance?.LoginScreen()
                    }
                    alertController.addAction(alertConfirm)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    //group.restaurantGroup = response
                    //로컬 파일로 저장
                    let dicts:[[String: Any]] = response.map {
                        (restaurantGroup: RestaurantGroup) -> [String: Any] in
                        return [
                            "category": restaurantGroup.category,
                            "text": restaurantGroup.text,
                            ]
                    }
                    UserDefaults.standard.set(dicts, forKey: SuperConstants.JJamUserDefaultsKeyRestaurantGroup)
                    UserDefaults.standard.synchronize()
                    
                    //ViewControllers 생성 작업을 _id 값을 필수 작업이어서 내부에서 진행 한다.
                    let businessUsersMealList = BusinessUsersMealList(_id: _id)                                             //업체 ID
                    let businessUsersMenuManagement = BusinessUsersMenuManagement(_id: _id)                                 //메뉴 관리
                    let businessUsersSettings = BusinessUsersSettings(_id: _id)                                             //설정
                    
                    self.viewControllers = [
                        UINavigationController(rootViewController: businessUsersMealList),
                        UINavigationController(rootViewController: businessUsersMenuManagement),
                        UINavigationController(rootViewController: businessUsersSettings),
                    ]
                }
            }
        }
    }
}
