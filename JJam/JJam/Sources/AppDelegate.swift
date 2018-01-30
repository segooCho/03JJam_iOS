//
//  AppDelegate.swift
//  JJam
//
//  Created by admin on 2017. 7. 12..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
import SwiftyHash
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    class var instance: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //광고 adMob-AppID
        GADMobileAds.configure(withApplicationID: AdMobConstants.adMobAppID)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = .white
       
        //로그인
        //LoginScreen()
        
        //회원 가입
        //UsersSignUpScreen()
        
        //GeneralUsersTabBar
        let generalUsersTabBar = GeneralUsersTabBar(selectIndex : 0)
        self.window?.rootViewController = generalUsersTabBar
        
        //BusinessUsersTabBar
        //let businessUsersTabBar = BusinessUsersTabBar(restaurant_Id: "5978502d57deb6283537150e", selectIndex: 0)
        //self.window?.rootViewController = businessUsersTabBar
        return true
    }
    
    //GeneralUsersTabBar
    func GeneralUsersTabBarScreen(selectIndex: Int) {
        //InterestRestaurantList()              : 관심 식당
        //GeneralUsersSettings()                : 설정
        let generalUsersTabBar = GeneralUsersTabBar(selectIndex: selectIndex)
        self.window?.rootViewController = generalUsersTabBar
    }

    //로그인
    func LoginScreen() {
        let login = Login()
        let navigationController = UINavigationController(rootViewController: login)
        self.window?.rootViewController = navigationController
    }
    
    //BusinessUsersTabBar(식단, 설정)
    func BusinessUsersTabBarScreen(restaurant_Id: String, selectIndex: Int) {
        //BusinessUsersMealList()                   : 식단
        //BusinessUsersSettings()                   : 설정
        //let businessUsersTabBar = BusinessUsersTabBar(restaurant_Id: restaurant_Id, selectIndex: selectIndex)
        let businessUsersTabBar = BusinessUsersTabBar(restaurant_Id: restaurant_Id)
        self.window?.rootViewController = businessUsersTabBar
    }

    //공지사항
    func BusinessUsersNoticeScreen(restaurant_Id: String) {
        let businessUsersNotice = BusinessUsersNotice(restaurant_Id: restaurant_Id)
        let navigationController = UINavigationController(rootViewController: businessUsersNotice)
        self.window?.rootViewController = navigationController
    }
}

