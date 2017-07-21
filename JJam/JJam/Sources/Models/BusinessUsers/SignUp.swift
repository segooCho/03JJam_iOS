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
    var password2: String
    var businessNumber: String
    var companyName: String
    var address: String
    var contactNumber : String
    var representative : String
    var imageString : String
    
    init(id: String, password: String, password2: String, businessNumber: String,
         companyName: String, address: String, contactNumber: String, representative: String, imageString: String) {
        self.id = id
        self.password = password
        self.password2 = password2
        self.businessNumber = businessNumber
        self.companyName = companyName
        self.address = address
        self.contactNumber = contactNumber
        self.representative = representative
        self.imageString = imageString
    }
}

