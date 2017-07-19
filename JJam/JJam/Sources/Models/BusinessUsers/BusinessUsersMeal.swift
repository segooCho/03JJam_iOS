//
//  BusinessUsersMeal.swift
//  JJam
//
//  Created by admin on 2017. 7. 18..
//  Copyright © 2017년 admin. All rights reserved.
//

struct BusinessUsersMeal {
    var id: String
    var imageString: String
    var dateString: String
    var summary: String
    
    init(id: String, imageString: String, dateString: String, summary: String) {
        self.id = id
        self.imageString = imageString
        self.dateString = dateString
        self.summary = summary
    }
}

