//
//  Meal.swift
//  JJam
//
//  Created by admin on 2017. 7. 15..
//  Copyright © 2017년 admin. All rights reserved.
//

struct Meal {
    var id: String
    var imageString: String
    var dateString: String
    var remarks: String
    
    init(id: String, imageString: String, dateString: String, remarks: String) {
        self.id = id
        self.imageString = imageString
        self.dateString = dateString
        self.remarks = remarks
    }
}
