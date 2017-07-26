//
//  GeneralUsersNetWorking.swift
//  JJam
//
//  Created by admin on 2017. 7. 21..
//  Copyright © 2017년 admin. All rights reserved.
//

import Alamofire

struct GeneralUsersNetWorking {
    //식당 찾기
    static func restaurantSearch(searchText: String, completion: @escaping (_ restaurantSearch: [RestaurantSearch]) -> Void) {
        let urlString = FixedCommonSet.networkinkBaseUrl + "restaurantSearch"
        let parameters: [String: Any] = [
            "searchText": searchText,
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            ]
        
        var restaurantSearch: [RestaurantSearch] = []
        
        Alamofire.request(urlString, method: .get, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<400)
            .responseJSON {
                    response in
                    switch response.result {
                    case .success(let value) :
                        guard let json = value as? [[String: Any]] else {break}
                        //TODO : 오류 처리 필요
                        let data = [RestaurantSearch](JSONArray: json)
                        restaurantSearch.append(contentsOf: data)
                        completion(restaurantSearch)
                    case .failure(let error) :
                        print("요청 실패 \(error)")
                        completion(restaurantSearch)
                    }
        }
        completion(restaurantSearch)
    }
    
    
    //식당 인증 & 공지사항
    static func restaurantInfo(restaurant_Id: String, completion: @escaping (_ restaurantInfo: [RestaurantInfo]) -> Void) {
        let urlString = FixedCommonSet.networkinkBaseUrl + "restaurantInfo"
        let parameters: [String: Any] = [
            "restaurant_Id": restaurant_Id,
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            ]
        
        var restaurantInfo: [RestaurantInfo] = []
        
        Alamofire.request(urlString, method: .get, parameters: parameters, headers: headers)
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
                    completion(restaurantInfo)
                }
        }
        completion(restaurantInfo)
    }
    
    //식단 조회
    static func mealSearch(restaurant_Id: String, segmentedIndexAndCode: Int, completion: @escaping (_ meal: [Meal]) -> Void) {
        let urlString = FixedCommonSet.networkinkBaseUrl + "mealSearch"
        let parameters: [String: Any] = [
            "restaurant_Id": restaurant_Id,
            "segmentedId": segmentedIndexAndCode,
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            ]
        
        var meal: [Meal] = []
        Alamofire.request(urlString, method: .get, parameters: parameters, headers: headers)
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
                    completion(meal)
                }
        }
        completion(meal)
    }
}
