//
//  Meal.swift
//  JJam
//
//  Created by admin on 2017. 7. 15..
//  Copyright © 2017년 admin. All rights reserved.
//

import ObjectMapper

struct Meal: Mappable {
    var meal_Id: String!
    var restaurant_Id: String!
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
    var message: String?            //리턴 메시지
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.meal_Id <- map["_id"]
        self.restaurant_Id <- map["restaurant_Id"]
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
        self.message <- map["message"]
        
        /* server : lookup sample
        let json = map.JSON["likeDocs"] as? [[String: Any]]
        if json != nil {
            self.likeDocs = json?[0]["uniqueId"] as! String
        } else {
            self.likeDocs = ""
        }
        */
    }
}
