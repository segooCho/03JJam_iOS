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
            "restaurant_Id": restaurant_Id,
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            ]
        
        var restaurantInfo: [RestaurantInfo] = []
        
        Alamofire.request(Url.restaurantInfo, method: .post, parameters: parameters, headers: headers)
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
            "restaurant_Id": restaurant_Id,
            "segmentedId": segmentedIndexAndCode,
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            ]
        
        var meal: [Meal] = []
        Alamofire.request(Url.mealSearch, method: .post, parameters: parameters, headers: headers)
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
            "meal_Id": meal_Id,
            "uniqueId": uniqueId,
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            ]
        
        var restaurantInfo: [RestaurantInfo] = []
        Alamofire.request(Url.mealLikeCount, method: .post, parameters: parameters, headers: headers)
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
    static func mealLike(meal_Id: String, uniqueId: String, completion: @escaping (_ restaurantInfo: [RestaurantInfo]) -> Void) {
        let parameters: [String: Any] = [
            "meal_Id": meal_Id,
            "uniqueId": uniqueId
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            ]
        
        var restaurantInfo: [RestaurantInfo] = []
        Alamofire.request(Url.mealLike, method: .put, parameters: parameters, headers: headers)
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
}

