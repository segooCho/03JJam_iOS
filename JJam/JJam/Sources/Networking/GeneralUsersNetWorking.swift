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
        let parameters: [String: Any] = [
            "searchText": searchText,
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            ]
        
        var restaurantSearch: [RestaurantSearch] = []
        
        Alamofire.request(Url.restaurantSearch, method: .post, parameters: parameters, headers: headers)
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
                        let data = [RestaurantSearch](JSONArray: [netWorkingErrorMessage])
                        restaurantSearch.append(contentsOf: data)
                        completion(restaurantSearch)
                    }
        }
        completion(restaurantSearch)
    }
}
