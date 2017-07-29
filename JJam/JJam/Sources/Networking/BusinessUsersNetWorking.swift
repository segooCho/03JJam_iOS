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
                    let data = [RestaurantInfo](JSONArray: [["message": "네트워크 통신에 문제가 발생하여 데이터 요청 작업을 실패했습니다."]])
                    restaurantInfo.append(contentsOf: data)
                    completion(restaurantInfo)
                }
        }
        completion(restaurantInfo)
    }
    
    //회원 가입
    //static func restaurantSignUp(signUp: [SignUp], imageURL: URL?, completion: @escaping (_ restaurantInfo: [RestaurantInfo]) -> Void) {
    static func restaurantSignUp(signUp: [SignUp], image: UIImage?, completion: @escaping (_ restaurantInfo: [RestaurantInfo]) -> Void) {
        // pod SwiftyHash
        let sha256Hex: String = signUp[0].password.digest.sha256
        
        let urlString = FixedCommonSet.networkinkBaseUrl + "restaurantSignUp"
        let parameters: [String: Any] = [
            "id": signUp[0].id,
            "password": sha256Hex,
            "businessNumber": signUp[0].businessNumber,
            "companyName": signUp[0].companyName,
            "address": signUp[0].address,
            "contactNumber": signUp[0].contactNumber,
            "representative": signUp[0].representative,
            ]
        var restaurantInfo: [RestaurantInfo] = []
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            if image != nil {
                if let imageData = UIImageJPEGRepresentation(image!, 1) {
                    multipartFormData.append(imageData, withName: "businessLicenseImage", fileName: "photo.jpg", mimeType: "image/jpeg")
                }
            }
            /*
            if imageURL != nil {
                multipartFormData.append(imageURL!, withName: "businessLicenseImage")
            }
            */
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
}
