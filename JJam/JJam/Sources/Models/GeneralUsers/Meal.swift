//
//  Meal.swift
//  JJam
//
//  Created by admin on 2017. 7. 15..
//  Copyright © 2017년 admin. All rights reserved.
//

import ObjectMapper

struct Meal: Mappable {
    var _id: String!
    var mealDate: String!
    var mealDateLabel: String!
    var location: String!
    var division: String!
    var stapleFood: String!
    var soup: String!
    var sideDish1: String!
    var sideDish2: String!
    var sideDish3: String!
    var sideDish4: String!
    var dessert: String!
    var remarks: String!
    var foodImage: String!
    
    
    var summary: String!
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self._id <- map["_id"]
        self.mealDate <- map["mealDate"]
        self.mealDateLabel <- map["mealDateLabel"]
        self.location <- map["location"]
        self.division <- map["division"]
        self.stapleFood <- map["stapleFood"]
        self.soup <- map["soup"]
        self.sideDish1 <- map["sideDish1"]
        self.sideDish2 <- map["sideDish2"]
        self.sideDish3 <- map["sideDish3"]
        self.sideDish4 <- map["sideDish4"]
        self.dessert <- map["dessert"]
        self.remarks <- map["remarks"]
        self.foodImage <- map["foodImage"]
    }
}



/*
struct Meal {
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
*/
