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
    init(restaurant_Id: String) {
        super.init(nibName: nil, bundle: nil)

        let tempViewController = TempViewController()
        //임시 화면 : 임시 화면 처리용
        self.viewControllers = [
            tempViewController,
        ]
        restaurantGroup(restaurant_Id: restaurant_Id)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //식당 Group 조회
    func restaurantGroup(restaurant_Id: String) {
        //UICommonSetLoadingService(self.activityIndicatorView, service: true)
        /*group: "all"=전체*/
        BusinessUsersNetWorking.restaurantGroup(restaurant_Id: restaurant_Id, group: "") { [weak self] response in
            guard let `self` = self else { return }
            if response.count > 0 {
                let message = response[0].message
                if message != nil {
                    //TempViewController에서 시작된 것을 종료
                    UICommonSetLoadingService(self.activityIndicatorView, service: false)
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
                    
                    //식단 항목 Group
                    BusinessGroupArray.location.removeAllObjects()
                    BusinessGroupArray.division.removeAllObjects()
                    BusinessGroupArray.stapleFood.removeAllObjects()
                    BusinessGroupArray.soup.removeAllObjects()
                    BusinessGroupArray.sideDish.removeAllObjects()
                    BusinessGroupArray.dessert.removeAllObjects()
                    
                    for data in response {
                        switch data.group {
                        case "location":
                            BusinessGroupArray.location.add(data.text)
                        case "division":
                            BusinessGroupArray.division.add(data.text)
                        case "stapleFood":
                            BusinessGroupArray.stapleFood.add(data.text)
                        case "soup":
                            BusinessGroupArray.soup.add(data.text)
                        case "sideDish":
                            BusinessGroupArray.sideDish.add(data.text)
                        case "dessert":
                            BusinessGroupArray.dessert.add(data.text)
                        default:
                            print("No Group")
                        }
                    }
                    
                    //TempViewController에서 시작된 것을 종료
                    UICommonSetLoadingService(self.activityIndicatorView, service: false)

                    //ViewControllers 생성 작업을 restaurant_Id 값을 필수 작업이어서 내부에서 진행 한다.
                    let businessUsersMealList = BusinessUsersMealList(restaurant_Id: restaurant_Id)                                             //업체 ID
                    let businessUsersMenuManagement = BusinessUsersMenuManagement(restaurant_Id: restaurant_Id)                                 //메뉴 관리
                    let businessUsersSettings = BusinessUsersSettings(restaurant_Id: restaurant_Id)                                             //설정
                    
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
