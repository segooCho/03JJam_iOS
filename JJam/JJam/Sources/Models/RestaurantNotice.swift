//
//  RestaurantNotice.swift
//  JJam
//
//  Created by admin on 2017. 7. 25..
//  Copyright © 2017년 admin. All rights reserved.
//


import ObjectMapper

struct RestaurantNotice: Mappable {
    var notice: String!
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.notice <- map["notice"]
    }
}


