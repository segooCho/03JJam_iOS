//
//  Member.swift
//  JJam
//
//  Created by admin on 2017. 8. 4..
//  Copyright © 2017년 admin. All rights reserved.
//


import ObjectMapper

struct Member: Mappable {
    var id: String?
    var businessNumber: String?
    var companyName: String?
    var address: String?
    var contactNumber: String?
    var representative: String?
    var businessLicenseImage: String?
    var message: String?                    //리턴 메시지
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.id <- map["id"]
        self.businessNumber <- map["businessNumber"]
        self.companyName <- map["companyName"]
        self.address <- map["address"]
        self.contactNumber <- map["contactNumber"]
        self.representative <- map["representative"]
        self.businessLicenseImage <- map["businessLicenseImage"]
        self.message <- map["message"]
    }
}
