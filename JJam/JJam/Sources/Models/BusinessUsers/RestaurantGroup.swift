//
//  RestaurantGroup.swift
//  JJam
//
//  Created by admin on 2017. 7. 30..
//  Copyright © 2017년 admin. All rights reserved.
//

import ObjectMapper

struct RestaurantGroup: Mappable {
    var group: String!
    var text: String!
    var message: String?            //리턴 메시지
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.group <- map["group"]
        self.text <- map["text"]
        self.message <- map["message"]
    }
}

struct RestaurantGroupUserDefaults {
     var group: String
     var text: String
    
     init(group: String, text: String) {
     self.group = group
     self.text = text
     }
}

