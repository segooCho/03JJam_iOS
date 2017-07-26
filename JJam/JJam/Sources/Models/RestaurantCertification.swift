//
//  RestaurantCertification.swift
//  JJam
//
//  Created by admin on 2017. 7. 25..
//  Copyright © 2017년 admin. All rights reserved.
//

import ObjectMapper

struct RestaurantCertification: Mappable {
    var certification: String?
    var message: String?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.certification <- map["certification"]
        self.message <- map["message"]
    }
}

