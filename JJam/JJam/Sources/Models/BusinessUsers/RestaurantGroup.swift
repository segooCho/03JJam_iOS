//
//  RestaurantGroup.swift
//  JJam
//
//  Created by admin on 2017. 7. 30..
//  Copyright © 2017년 admin. All rights reserved.
//

import ObjectMapper

struct RestaurantGroup: Mappable {
    var category: String!
    var text: String!
    var message: String?            //리턴 메시지
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.category <- map["category"]
        self.text <- map["text"]
        self.message <- map["message"]
    }
}

struct RestaurantGroupUserDefaults {
     var category: String
     var text: String
    
     init(category: String, text: String) {
     self.category = category
     self.text = text
     }
}

