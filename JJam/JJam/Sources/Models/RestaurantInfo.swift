//
//  RestaurantInfo.swift
//  JJam
//
//  Created by admin on 2017. 7. 25..
//  Copyright © 2017년 admin. All rights reserved.
//

import ObjectMapper

struct RestaurantInfo: Mappable {
    var id: String?                 //사용자 ID
    var certification: String?      //인증 구분 (y,n)
    var notice: String?             //공지사항
    var message: String?            //리턴 메시지
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.id <- map["id"]
        self.certification <- map["certification"]
        self.notice <- map["notice"]
        self.message <- map["message"]
    }
}

