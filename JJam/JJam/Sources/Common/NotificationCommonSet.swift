//
//  Notification.swift
//  JJam
//
//  Created by admin on 2017. 7. 24..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

let JJamUserDefaultsKeyInterestRestaurantList = "JJamUserDefaultsKeyInterestRestaurantList"

extension Notification.Name{
    //식당 찾기에서 관심 식당으로 이동 시
    static var interestRestaurantDidAdd: Notification.Name {return .init("interestRestaurant")}
    //상세 식단에서 식단리스트로 이동 시
    static var businessUsersMealListDidAdd: Notification.Name {return .init("businessUsersMealList")}
}
