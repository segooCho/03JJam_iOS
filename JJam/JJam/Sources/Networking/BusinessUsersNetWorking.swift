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
    static func restaurantGroup(restaurant_Id: String, completion: @escaping (_ restaurantGroup: [RestaurantGroup]) -> Void) {
        let parameters: [String: Any] = [
            "restaurant_Id": restaurant_Id,
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            ]
        
        var restaurantGroup: [RestaurantGroup] = []
        
        Alamofire.request(Url.restaurantGroup, method: .post, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<400)
            .responseJSON {
                response in
                switch response.result {
                case .success(let value) :
                    guard let json = value as? [[String: Any]] else {break}
                    //TODO : 오류 처리 필요
                    let data = [RestaurantGroup](JSONArray: json)
                    restaurantGroup.append(contentsOf: data)
                    completion(restaurantGroup)
                case .failure(let error) :
                    print("요청 실패 \(error)")
                    let data = [RestaurantGroup](JSONArray: [["message": "네트워크 통신에 문제가 발생하여 데이터 요청 작업을 실패했습니다."]])
                    restaurantGroup.append(contentsOf: data)
                    completion(restaurantGroup)
                }
        }
        completion(restaurantGroup)
    }
    
    //POST : 식단 Edit & New
    static func restaurantMeal(Oid: String,
                               businessUsersMeal: [BusinessUsersMeal],
                               image: UIImage?,
                               editImage: String!,
                               completion: @escaping (_ restaurantInfo: [RestaurantInfo]) -> Void) {
        //Edit & New 구분
        var urlString: String
        var param: String
        if mealDetailTuple.writeMode {
            urlString = Url.mealWrite
            param = "restaurant_Id"                         //Meal 신규   (조건 : restaurant_Id)
        } else {
            urlString = Url.mealEdit
            param = "meal_Id"                               //Meal 수정   (조건 : meal_Id)
        }
        
        let parameters: [String: Any] = [
            param: Oid,
            "mealDate": businessUsersMeal[0].mealDate,
            "location": businessUsersMeal[0].location,
            "division": businessUsersMeal[0].division,
            "stapleFood": businessUsersMeal[0].stapleFood,
            "soup": businessUsersMeal[0].soup,
            "sideDish1": businessUsersMeal[0].sideDish1,
            "sideDish2": businessUsersMeal[0].sideDish2,
            "sideDish3": businessUsersMeal[0].sideDish3,
            "sideDish4": businessUsersMeal[0].sideDish4,
            "dessert": businessUsersMeal[0].dessert,
            "remarks": businessUsersMeal[0].remarks,
            "editImage": editImage,                         //"NoImageFound.jpg" 가 설정되면 기존 이미지 파일 삭제(변경시에만 사용)
            ]
        
        var restaurantInfo: [RestaurantInfo] = []
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            if image != nil {
                if let imageData = UIImageJPEGRepresentation(image!, 1) {
                    multipartFormData.append(imageData, withName: "foodImage", fileName: "photo.jpg", mimeType: "image/jpeg")
                }
            }
            for (key, value) in parameters {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
        }, to: urlString, method:.post, encodingCompletion: { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    switch response.result {
                    case .success(let value) :
                        guard let json = value as? [[String: Any]] else {break}
                        //TODO : 오류 처리 필요
                        let data = [RestaurantInfo](JSONArray: json)
                        restaurantInfo.append(contentsOf: data)
                        completion(restaurantInfo)
                    case .failure(let error) :
                        print("요청 실패 \(error)")
                        let data = [RestaurantInfo](JSONArray: [["message": "네트워크 통신에 문제가 발생하여 데이터 요청 작업을 실패했습니다."]])
                        restaurantInfo.append(contentsOf: data)
                        completion(restaurantInfo)
                    }
                }
            case .failure(let encodingError):
                print("요청 실패 \(encodingError)")
                let data = [RestaurantInfo](JSONArray: [["message": "네트워크 통신에 문제가 발생하여 데이터 요청 작업을 실패했습니다.(encodingError)"]])
                restaurantInfo.append(contentsOf: data)
                completion(restaurantInfo)
            }
        })
        completion(restaurantInfo)
    }
    
    //식당 인증 & 공지사항
    static func mealDel(meal_Id: String, completion: @escaping (_ restaurantInfo: [RestaurantInfo]) -> Void) {
        let parameters: [String: Any] = [
            "meal_Id": meal_Id,
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            ]
        
        var restaurantInfo: [RestaurantInfo] = []
        
        Alamofire.request(Url.mealDel, method: .post, parameters: parameters, headers: headers)
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
                    let data = [RestaurantInfo](JSONArray: [["message": "네트워크 통신에 문제가 발생하여 데이터 요청 작업을 실패했습니다."]])
                    restaurantInfo.append(contentsOf: data)
                    completion(restaurantInfo)
                }
        }
        completion(restaurantInfo)
    }
    
    //식당 공지사항 수정
    static func restaurantNoticeEdit(restaurant_Id: String, notice: String, completion: @escaping (_ restaurantInfo: [RestaurantInfo]) -> Void) {
        let parameters: [String: Any] = [
            "restaurant_Id": restaurant_Id,
            "notice": notice,
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            ]
        
        var restaurantInfo: [RestaurantInfo] = []
        
        Alamofire.request(Url.restaurantNoticeEdit, method: .post, parameters: parameters, headers: headers)
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
                    let data = [RestaurantInfo](JSONArray: [["message": "네트워크 통신에 문제가 발생하여 데이터 요청 작업을 실패했습니다."]])
                    restaurantInfo.append(contentsOf: data)
                    completion(restaurantInfo)
                }
        }
        completion(restaurantInfo)
    }
    
    
    
}
