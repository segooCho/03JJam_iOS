//
//  RestaurantSearch.swift
//  JJam
//
//  Created by admin on 2017. 7. 18..
//  Copyright © 2017년 admin. All rights reserved.
//

struct RestaurantSearch {
    var id: String
    var companyName: String
    var certification: String
    var address: String
    var contactNumber: String
    var representative: String
    var isDone: Bool
    
    init(id: String, companyName: String, certification: String, address: String, contactNumber: String, representative: String, isDone: Bool = false) {
        self.id = id
        self.companyName = companyName
        self.certification = certification
        self.address = address
        self.contactNumber = contactNumber
        self.representative = representative
        self.isDone = isDone
    }
}
