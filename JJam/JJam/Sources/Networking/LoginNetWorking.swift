//
//  LoginNetWorking.swift
//  JJam
//
//  Created by admin on 2017. 7. 30..
//  Copyright © 2017년 admin. All rights reserved.
//

import Alamofire

struct LoginNetWorking {
    //로그인
    static func restaurantLogin(id: String, password: String, completion: @escaping (_ restaurantInfo: [RestaurantInfo]) -> Void) {
        // pod SwiftyHash
        let sha256Hex: String = password.digest.sha256
        let parameters: [String: Any] = [
            "id": id,
            "password": sha256Hex,
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            ]
        
        var restaurantInfo: [RestaurantInfo] = []
        
        Alamofire.request(FixedBaseUrl.restaurantLogin, method: .post, parameters: parameters, headers: headers)
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
    
    //회원 정보
    static func restaurantMember(restaurant_Id: String, completion: @escaping (_ member: [Member]) -> Void) {
        let parameters: [String: Any] = [
            "restaurant_Id": restaurant_Id,
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            ]
        
        var member: [Member] = []
        
        Alamofire.request(FixedBaseUrl.restaurantMember, method: .post, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<400)
            .responseJSON {
                response in
                switch response.result {
                case .success(let value) :
                    guard let json = value as? [[String: Any]] else {break}
                    //TODO : 오류 처리 필요
                    let data = [Member](JSONArray: json)
                    member.append(contentsOf: data)
                    completion(member)
                case .failure(let error) :
                    print("요청 실패 \(error)")
                    let data = [Member](JSONArray: [netWorkingErrorMessage])
                    member.append(contentsOf: data)
                    completion(member)
                }
        }
        completion(member)
    }

    
    //회원 가입
    static func restaurantSignUp(signUp: [SignUp], image: UIImage?, completion: @escaping (_ restaurantInfo: [RestaurantInfo]) -> Void) {
        // pod SwiftyHash
        let sha256Hex: String = signUp[0].password.digest.sha256        
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
            for (key, value) in parameters {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
        }, to: FixedBaseUrl.restaurantSignUp, method:.post, encodingCompletion: { (result) in
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
                        let data = [RestaurantInfo](JSONArray: [netWorkingErrorMessage])
                        restaurantInfo.append(contentsOf: data)
                        completion(restaurantInfo)
                    }
                }
            case .failure(let encodingError):
                print("요청 실패 \(encodingError)")
                let data = [RestaurantInfo](JSONArray: [netWorkingErrorMessageEncodingError])
                restaurantInfo.append(contentsOf: data)
                completion(restaurantInfo)
            }
        })
        completion(restaurantInfo)
    }
    
    //회원 수정
    static func restaurantEdit(restaurant_Id: String, signUp: [SignUp], image: UIImage?, editImage: String, completion: @escaping (_ restaurantInfo: [RestaurantInfo]) -> Void) {
        
        // pod SwiftyHash
        var sha256Hex: String = ""
        if signUp[0].password != "" {
            sha256Hex = signUp[0].password.digest.sha256
        }
        
        let parameters: [String: Any] = [
            "restaurant_Id": restaurant_Id,
            "password": sha256Hex,
            "businessNumber": signUp[0].businessNumber,
            "companyName": signUp[0].companyName,
            "address": signUp[0].address,
            "contactNumber": signUp[0].contactNumber,
            "representative": signUp[0].representative,
            "editImage": editImage,
            ]
        var restaurantInfo: [RestaurantInfo] = []
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            if image != nil {
                if let imageData = UIImageJPEGRepresentation(image!, 1) {
                    multipartFormData.append(imageData, withName: "businessLicenseImage", fileName: "photo.jpg", mimeType: "image/jpeg")
                }
            }
            for (key, value) in parameters {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
        }, to: FixedBaseUrl.restaurantEdit, method:.post, encodingCompletion: { (result) in
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
                        let data = [RestaurantInfo](JSONArray: [netWorkingErrorMessage])
                        restaurantInfo.append(contentsOf: data)
                        completion(restaurantInfo)
                    }
                }
            case .failure(let encodingError):
                print("요청 실패 \(encodingError)")
                let data = [RestaurantInfo](JSONArray: [netWorkingErrorMessageEncodingError])
                restaurantInfo.append(contentsOf: data)
                completion(restaurantInfo)
            }
        })
        completion(restaurantInfo)
    }
}
