//
//  RestaurantInfo.swift
//  JJam
//
//  Created by admin on 2017. 7. 25..
//  Copyright © 2017년 admin. All rights reserved.
//

import ObjectMapper

struct RestaurantInfo: Mappable {
    var restaurant_Id: String?      //Oid
    var id: String?                 //사용자 ID
    var certification: String?      //인증 구분 (y:승인,n:미승인)
    var notice: String?             //공지사항
    var check: String?              //식당 맛있어요 Check 구분(y,n)
    var cnt: Int?                   //맛있어요 카운트
    var text: String?               //운영자 공지사항
    var bannerCheck: String?        //전면 광고 Check 구분(y,n)
    var message: String?            //리턴 메시지
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.restaurant_Id <- map["_id"]
        self.id <- map["id"]
        self.certification <- map["certification"]
        self.notice <- map["notice"]
        self.check <- map["check"]
        self.cnt <- map["cnt"]
        self.text <- map["text"]
        self.bannerCheck <- map["bannerCheck"]
        self.message <- map["message"]
    }
}

