//
//  SignUp.swift
//  JJam
//
//  Created by admin on 2017. 7. 20..
//  Copyright © 2017년 admin. All rights reserved.
//

struct SignUp {
    var id: String
    var password: String
    var businessNumber: String
    var companyName: String
    var address: String
    var contactNumber : String
    var representative : String
    
    init(id: String, password: String, businessNumber: String,
         companyName: String, address: String, contactNumber: String, representative: String) {
        self.id = id
        self.password = password
        self.businessNumber = businessNumber
        self.companyName = companyName
        self.address = address
        self.contactNumber = contactNumber
        self.representative = representative
    }
}
