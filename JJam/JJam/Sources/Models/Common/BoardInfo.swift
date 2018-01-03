//
//  BoardInfo.swift
//  JJam
//
//  Created by admin on 2018. 1. 3..
//  Copyright © 2018년 admin. All rights reserved.
//

import ObjectMapper

struct BoardInfo: Mappable {
    var board_Id: String!
    var restaurant_Id: String!
    var uniqueId: String!
    var division: String!
    var title: String!
    var contents: String!
    var answer: String!
    var message: String?            //리턴 메시지
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.board_Id <- map["_id"]
        self.restaurant_Id <- map["restaurant_Id"]
        self.uniqueId <- map["uniqueId"]
        self.division <- map["division"]
        self.title <- map["title"]
        self.contents <- map["contents"]
        self.answer <- map["answer"]
        self.message <- map["message"]
    }
}
