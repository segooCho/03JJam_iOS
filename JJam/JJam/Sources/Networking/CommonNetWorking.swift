//
//  CommonNetWorking.swift
//  JJam
//
//  Created by admin on 2017. 8. 10..
//  Copyright © 2017년 admin. All rights reserved.
//


import Alamofire

struct CommonNetWorking {
    //식당 인증 & 공지사항
    static func restaurantInfo(restaurant_Id: String, completion: @escaping (_ restaurantInfo: [RestaurantInfo]) -> Void) {
        let parameters: [String: Any] = [
            "osVer": osVer,
            "appVer": appVer,
            "restaurant_Id": restaurant_Id,
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            ]
        
        var restaurantInfo: [RestaurantInfo] = []
        
        Alamofire.request(FixedBaseUrl.restaurantInfo, method: .post, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<400)
            .responseJSON {
                response in
                switch response.result {
                case .success(let value) :
                    guard let json = value as? [[String: Any]] else {break}
                    //TODO : 오류 처리 필요
                    let data = [RestaurantInfo](JSONArray: json)
                    restaurantInfo.append(contentsOf: data)
                    completion(restaurantInfo)
                case .failure(let error) :
                    print("요청 실패 \(error)")
                    let data = [RestaurantInfo](JSONArray: [netWorkingErrorMessage])
                    restaurantInfo.append(contentsOf: data)
                    completion(restaurantInfo)
                }
        }
        completion(restaurantInfo)
    }
    
    //식단 조회
    static func mealSearch(restaurant_Id: String, segmentedIndexAndCode: Int, completion: @escaping (_ meal: [Meal]) -> Void) {
        let parameters: [String: Any] = [
            "osVer": osVer,
            "appVer": appVer,
            "restaurant_Id": restaurant_Id,
            "segmentedId": segmentedIndexAndCode,
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            ]
        
        var meal: [Meal] = []
        Alamofire.request(FixedBaseUrl.mealSearch, method: .post, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<400)
            .responseJSON {
                response in
                switch response.result {
                case .success(let value) :
                    guard let json = value as? [[String: Any]] else {break}
                    //TODO : 오류 처리 필요
                    let data = [Meal](JSONArray: json)
                    meal.append(contentsOf: data)
                    completion(meal)
                case .failure(let error) :
                    print("요청 실패 \(error)")
                    let data = [Meal](JSONArray: [netWorkingErrorMessage])
                    meal.append(contentsOf: data)
                    completion(meal)
                }
        }
        completion(meal)
    }
    
    //식단 맛있어요 카운터
    static func mealLikeCount(meal_Id: String, uniqueId: String, completion: @escaping (_ restaurantInfo: [RestaurantInfo]) -> Void) {
        let parameters: [String: Any] = [
            "osVer": osVer,
            "appVer": appVer,
            "meal_Id": meal_Id,
            "uniqueId": uniqueId,
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            ]
        
        var restaurantInfo: [RestaurantInfo] = []
        Alamofire.request(FixedBaseUrl.mealLikeCount, method: .post, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<400)
            .responseJSON {
                response in
                switch response.result {
                case .success(let value) :
                    guard let json = value as? [[String: Any]] else {break}
                    //TODO : 오류 처리 필요
                    let data = [RestaurantInfo](JSONArray: json)
                    restaurantInfo.append(contentsOf: data)
                    completion(restaurantInfo)
                case .failure(let error) :
                    print("요청 실패 \(error)")
                    let data = [RestaurantInfo](JSONArray: [netWorkingErrorMessage])
                    restaurantInfo.append(contentsOf: data)
                    completion(restaurantInfo)
                }
        }
        completion(restaurantInfo)
    }
    
    //식단 맛있어요 카운터
    static func mealLike(restaurant_Id: String, meal_Id: String, uniqueId: String, completion: @escaping (_ restaurantInfo: [RestaurantInfo]) -> Void) {
        let parameters: [String: Any] = [
            "osVer": osVer,
            "appVer": appVer,
            "restaurant_Id": restaurant_Id,
            "meal_Id": meal_Id,
            "uniqueId": uniqueId,
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            ]
        
        var restaurantInfo: [RestaurantInfo] = []
        Alamofire.request(FixedBaseUrl.mealLike, method: .put, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<400)
            .responseJSON {
                response in
                switch response.result {
                case .success(let value) :
                    guard let json = value as? [[String: Any]] else {break}
                    //TODO : 오류 처리 필요
                    let data = [RestaurantInfo](JSONArray: json)
                    restaurantInfo.append(contentsOf: data)
                    completion(restaurantInfo)
                case .failure(let error) :
                    print("요청 실패 \(error)")
                    let data = [RestaurantInfo](JSONArray: [netWorkingErrorMessage])
                    restaurantInfo.append(contentsOf: data)
                    completion(restaurantInfo)
                }
        }
        completion(restaurantInfo)
    }
    
    //운영자 공지사항 조회
    static func managerNoticeSearch(division: String, completion: @escaping (_ restaurantInfo: [RestaurantInfo]) -> Void) {
        let parameters: [String: Any] = [
            "osVer": osVer,
            "appVer": appVer,
            "division": division,
        ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            ]
        
        var restaurantInfo: [RestaurantInfo] = []
        
        Alamofire.request(FixedBaseUrl.managerNoticeSearch, method: .post, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<400)
            .responseJSON {
                response in
                switch response.result {
                case .success(let value) :
                    guard let json = value as? [[String: Any]] else {break}
                    //TODO : 오류 처리 필요
                    let data = [RestaurantInfo](JSONArray: json)
                    restaurantInfo.append(contentsOf: data)
                    completion(restaurantInfo)
                case .failure(let error) :
                    print("요청 실패 \(error)")
                    let data = [RestaurantInfo](JSONArray: [netWorkingErrorMessage])
                    restaurantInfo.append(contentsOf: data)
                    completion(restaurantInfo)
                }
        }
        completion(restaurantInfo)
    }
 
    //문의 또는 식당요청 게시판 조회
    static func boardSearch(restaurant_Id: String, uniqueId: String, completion: @escaping (_ boardInfo: [BoardInfo]) -> Void) {
        let parameters: [String: Any] = [
            "osVer": osVer,
            "appVer": appVer,
            "restaurant_Id": restaurant_Id,
            "uniqueId": uniqueId,
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            ]
        
        var boardInfo: [BoardInfo] = []
        Alamofire.request(FixedBaseUrl.boardSearch, method: .post, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<400)
            .responseJSON {
                response in
                switch response.result {
                case .success(let value) :
                    guard let json = value as? [[String: Any]] else {break}
                    //TODO : 오류 처리 필요
                    let data = [BoardInfo](JSONArray: json)
                    boardInfo.append(contentsOf: data)
                    completion(boardInfo)
                case .failure(let error) :
                    print("요청 실패 \(error)")
                    let data = [BoardInfo](JSONArray: [netWorkingErrorMessage])
                    boardInfo.append(contentsOf: data)
                    completion(boardInfo)
                }
        }
        completion(boardInfo)
    }
    
    //문의 또는 식당요청 게시판 삭제
    static func boardDel(board_Id: String, completion: @escaping (_ boardInfo: [BoardInfo]) -> Void) {
        let parameters: [String: Any] = [
            "osVer": osVer,
            "appVer": appVer,
            "Board_Id": board_Id,
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            ]
        
        var boardInfo: [BoardInfo] = []
        
        Alamofire.request(FixedBaseUrl.boardDel, method: .delete, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<400)
            .responseJSON {
                response in
                switch response.result {
                case .success(let value) :
                    guard let json = value as? [[String: Any]] else {break}
                    //TODO : 오류 처리 필요
                    let data = [BoardInfo](JSONArray: json)
                    boardInfo.append(contentsOf: data)
                    completion(boardInfo)
                case .failure(let error) :
                    print("요청 실패 \(error)")
                    let data = [BoardInfo](JSONArray: [netWorkingErrorMessage])
                    boardInfo.append(contentsOf: data)
                    completion(boardInfo)
                }
        }
        completion(boardInfo)
    }
    
    //문의 또는 식당요청 게시판 등록 & 수정
    static func boardEditAndWrite(boardCellInfo: [BoardCellInfo], completion: @escaping (_ boardInfo: [BoardInfo]) -> Void) {
        let parameters: [String: Any] = [
            "osVer": osVer,
            "appVer": appVer,
            "Board_Id": boardCellInfo[0].board_Id,
            "restaurant_Id": boardCellInfo[0].restaurant_Id,
            "uniqueId": boardCellInfo[0].uniqueId,
            "division": boardCellInfo[0].division,
            "title": boardCellInfo[0].title,
            "contents": boardCellInfo[0].contents,
            "answer": boardCellInfo[0].answer,
        ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            ]
        
        var urlString: String
        var method: HTTPMethod
        if boardCellInfo[0].board_Id == "" {
            urlString = FixedBaseUrl.boardWrite
            method = .post
        } else {
            urlString = FixedBaseUrl.boardEdit
            method = .put
        }
        
        var boardInfo: [BoardInfo] = []
        
        Alamofire.request(urlString, method: method, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<400)
            .responseJSON {
                response in
                switch response.result {
                case .success(let value) :
                    guard let json = value as? [[String: Any]] else {break}
                    //TODO : 오류 처리 필요
                    let data = [BoardInfo](JSONArray: json)
                    boardInfo.append(contentsOf: data)
                    completion(boardInfo)
                case .failure(let error) :
                    print("요청 실패 \(error)")
                    let data = [BoardInfo](JSONArray: [netWorkingErrorMessage])
                    boardInfo.append(contentsOf: data)
                    completion(boardInfo)
                }
        }
        completion(boardInfo)
    }
}

