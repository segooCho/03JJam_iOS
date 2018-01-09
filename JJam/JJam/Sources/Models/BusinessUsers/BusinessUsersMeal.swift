//
//  BusinessUsersMeal.swift
//  JJam
//
//  Created by admin on 2017. 7. 18..
//  Copyright © 2017년 admin. All rights reserved.
//

struct BusinessUsersMeal {
    var mealDate: String
    var location: String
    var division: String
    var stapleFood1: String
    var soup1: String
    var sideDish1: String
    var sideDish2: String
    var sideDish3: String
    var sideDish4: String
    var sideDish5: String
    var sideDish6: String
    var sideDish7: String
    var dessert1: String
    var dessert2: String
    var dessert3: String
    var remarks: String
    
    init(mealDate: String, location: String, division: String, stapleFood1: String, soup1: String,
         sideDish1: String, sideDish2: String, sideDish3: String, sideDish4: String
        , sideDish5: String, sideDish6: String, sideDish7: String
        , dessert1: String, dessert2: String, dessert3: String, remarks: String) {
        self.mealDate = mealDate
        self.location = location
        self.division = division
        self.stapleFood1 = stapleFood1
        self.soup1 = soup1
        self.sideDish1 = sideDish1
        self.sideDish2 = sideDish2
        self.sideDish3 = sideDish3
        self.sideDish4 = sideDish4
        self.sideDish5 = sideDish5
        self.sideDish6 = sideDish6
        self.sideDish7 = sideDish7
        self.dessert1 = dessert1
        self.dessert2 = dessert2
        self.dessert3 = dessert3
        self.remarks = remarks
    }
}

