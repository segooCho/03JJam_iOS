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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    //var destination : URL?
    
    class var instance: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = .white
        
        //로그인
        LoginScreen()
        
        /*
        //GeneralUsersTabBar
        let generalUsersTabBar = GeneralUsersTabBar(selectIndex : 0)
        self.window?.rootViewController = generalUsersTabBar
        */
        
        /*
        //BusinessUsersTabBar
        let businessUsersTabBar = BusinessUsersTabBar(selectIndex: 0)
        self.window?.rootViewController = businessUsersTabBar
        */
        
        
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
    
    //회원가입
    func BusinessUsersSignUpScreen() {
        let bsusinessUsersSignUp = BusinessUsersSignUp()
        let navigationController = UINavigationController(rootViewController: bsusinessUsersSignUp)
        self.window?.rootViewController = navigationController
    }
    
    //BusinessUsersTabBar(식단, 설정)
    func BusinessUsersTabBarScreen(selectIndex: Int) {
        //BusinessUsersMealList()                   : 식단
        //BusinessUsersSettings()                   : 설정
        let businessUsersTabBar = BusinessUsersTabBar(selectIndex: selectIndex)
        self.window?.rootViewController = businessUsersTabBar
    }

    //공지사항
    func BusinessUsersNoticeScreen() {
        let businessUsersNotice = BusinessUsersNotice(businessUsersRestaurantId: "1" )
        let navigationController = UINavigationController(rootViewController: businessUsersNotice)
        self.window?.rootViewController = navigationController
    }
    
    
    //메시지 처리 예시
    /*
     let alertController = UIAlertController(
     title: NSLocalizedString("Confirm", comment: "확인"),
     message: "관심 식당 추가",
     preferredStyle: .alert
     )
     let alertConfirm = UIAlertAction(
     title: NSLocalizedString("Confirm", comment: "확인"),
     style: .default) { _ in
     // 확인 후 작업
     }
     alertController.addAction(alertConfirm)
     self.present(alertController, animated: true, completion: nil)
     */

    
    
    
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

