//
//  BusinessUsersNetWorking.swift
//  JJam
//
//  Created by admin on 2017. 7. 26..
//  Copyright © 2017년 admin. All rights reserved.
//

import Alamofire

struct BusinessUsersNetWorking {
    //로그인
    static func restaurantLogin(id: String, password: String, completion: @escaping (_ restaurantInfo: [RestaurantInfo]) -> Void) {
        // pod SwiftyHash
        let sha256Hex: String = password.digest.sha256
        
        let urlString = FixedCommonSet.networkinkBaseUrl + "restaurantLogin"
        let parameters: [String: Any] = [
            "id": id,
            "password": sha256Hex,
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            ]
        
        var restaurantInfo: [RestaurantInfo] = []
        
        Alamofire.request(urlString, method: .post, parameters: parameters, headers: headers)
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
}
