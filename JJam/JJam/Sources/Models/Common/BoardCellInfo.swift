//
//  BoardCellInfo.swift
//  JJam
//
//  Created by admin on 2018. 1. 4..
//  Copyright © 2018년 admin. All rights reserved.
//

struct BoardCellInfo {
    var board_Id: String
    var restaurant_Id: String
    var uniqueId: String
    var division: String
    var title: String
    var contents: String
    var answer: String
    var message: String

    init(board_Id: String, restaurant_Id: String, uniqueId: String
        , division: String, title: String, contents: String, answer: String, message: String) {
        self.board_Id = board_Id
        self.restaurant_Id = restaurant_Id
        self.uniqueId = uniqueId
        self.division = division
        self.title = title
        self.contents = contents
        self.answer = answer
        self.message = message
    }
    
}
