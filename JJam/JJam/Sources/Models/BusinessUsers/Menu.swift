//
//  Menu.swift
//  JJam
//
//  Created by admin on 2017. 7. 19..
//  Copyright © 2017년 admin. All rights reserved.
//

struct Menu {
    var id: String      //식당 ID
    var code: String    //코드 (주식:0, 국:1, 반찬:2, ,후식:3)
    var food: String    //음식명
    var isDone: Bool

    init(id: String, code: String, food: String, isDone: Bool = false) {
        self.id = id
        self.code = code
        self.food = food
        self.isDone = isDone
    }
}
