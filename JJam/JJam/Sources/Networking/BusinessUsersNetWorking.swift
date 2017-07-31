//
//  BusinessUsersNetWorking.swift
//  JJam
//
//  Created by admin on 2017. 7. 26..
//  Copyright © 2017년 admin. All rights reserved.
//

import Alamofire

struct BusinessUsersNetWorking {

    //GET : 식당 category 항목(Group) 조회
    static func restaurantGroup(_id: String, completion: @escaping (_ businessUsersGroup: [BusinessUsersGroup]) -> Void) {
        let urlString = FixedCommonSet.networkinkBaseUrl + "restaurantSearch"
        let parameters: [String: Any] = [
            "restaurant_Id": _id,
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            ]
        
        var businessUsersGroup: [BusinessUsersGroup] = []
        
        Alamofire.request(urlString, method: .get, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<400)
            .responseJSON {
                response in
                switch response.result {
                case .success(let value) :
                    guard let json = value as? [[String: Any]] else {break}
                    //TODO : 오류 처리 필요
                    let data = [BusinessUsersGroup](JSONArray: json)
                    businessUsersGroup.append(contentsOf: data)
                    completion(businessUsersGroup)
                case .failure(let error) :
                    print("요청 실패 \(error)")
                    let data = [BusinessUsersGroup](JSONArray: [["message": "네트워크 통신에 문제가 발생하여 데이터 요청 작업을 실패했습니다."]])
                    businessUsersGroup.append(contentsOf: data)
                    completion(businessUsersGroup)
                }
        }
        completion(businessUsersGroup)
    }
    
}
