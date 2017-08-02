//
//  RestaurantSearch.swift
//  JJam
//
//  Created by admin on 2017. 7. 18..
//  Copyright © 2017년 admin. All rights reserved.
//

import ObjectMapper

struct RestaurantSearch: Mappable {
    var restaurant_Id: String!
    var companyName: String!
    var certification: String!
    var address: String!
    var contactNumber: String!
    var representative: String!
    var isDone: Bool!
    var message: String?                //리턴 메시지

    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.restaurant_Id <- map["_id"]
        self.companyName <- map["companyName"]
        self.certification <- map["certification"]
        self.address <- map["address"]
        self.contactNumber <- map["contactNumber"]
        self.representative <- map["representative"]
        self.isDone = false
        self.message <- map["message"]
    }
}

