//
//  BusinessUsersGroup.swift
//  JJam
//
//  Created by admin on 2017. 7. 30..
//  Copyright © 2017년 admin. All rights reserved.
//

import ObjectMapper

struct BusinessUsersGroup: Mappable {
    var _id: String!
    var category: String!
    var text: String!
    var message: String?            //리턴 메시지
    
    
    var summary: String!
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self._id <- map["_id"]
        self.category <- map["category"]
        self.text <- map["text"]
        self.message <- map["message"]
    }
}
