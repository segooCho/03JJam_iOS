//
//  RestaurantInfo.swift
//  JJam
//
//  Created by admin on 2017. 7. 25..
//  Copyright © 2017년 admin. All rights reserved.
//

import ObjectMapper

struct RestaurantInfo: Mappable {
    var certification: String?
    var notice: String?
    var message: String?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.certification <- map["certification"]
        self.notice <- map["notice"]
        self.message <- map["message"]
    }
}

