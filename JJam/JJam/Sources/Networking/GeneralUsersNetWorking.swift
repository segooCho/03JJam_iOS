//
//  RGeneralUsersNetWorking.swift
//  JJam
//
//  Created by admin on 2017. 7. 21..
//  Copyright © 2017년 admin. All rights reserved.
//

import Alamofire
import ObjectMapper

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
                        let data = [RestaurantSearch](JSONArray: json) ?? [
                        ] //?? : 앞에 있는 연산자가 오류이면 []를 실행하라
                        restaurantSearch.append(contentsOf: data)
                        completion(restaurantSearch)
                    case .failure(let error) :
                        print("요청 실패 \(error)")
                        completion(restaurantSearch)
                    }
        }
        completion(restaurantSearch)
    }   //restaurantSearch
    
    
    
    
    
    
    
    
    
    
    
    
    /*******************************************************Test******************************************************/
    
    
    
    
    
    
    
    
    
    /*
    static func restaurantSearch(searchText: String, completion: @escaping (DataResponse<RestaurantSearch>) -> Void) {
        let urlString = FixedCommonSet.networkinkBaseUrl + "restaurantSearch"
        let parameters: [String: Any] = [
            "searchText": "벽산",
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            ]
        
        //var restaurantSearch: [RestaurantSearch] = []
        
        Alamofire.request(urlString, method: .get, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<400)
            .responseJSON { response in
                let response: DataResponse<RestaurantSearch> = response
                    .flatMap { value in
                        
                        let data = value as! Any
                        
                        //mapArray

                        
                        //let abc = Mapper<RestaurantSearch>().mapArray(JSONObject: value)

                        if let feed = Mapper<RestaurantSearch>().map(JSONObject: data) {
                        
                        
                        //if let feed = Mapper<RestaurantSearch>().map(JSONString: value as! String) {
                        //if let feed = Mapper<RestaurantSearch>().mapArray(JSONArray: value as! [[String: Any]])
                            return .success(feed)
                        } else {
                            return .failure(MappingError(from: value, to: RestaurantSearch.self))
                        }
                }
                completion(response)
        }
    }   //restaurantSearch
    */
}       //GeneralUsersNetWorking

                /*
                switch response.result {
                case .success(let value) :
                    guard let json = value as? [[String: Any]] else {break}
                    let data = [RestaurantSearch](JSONArray: json) ?? [] //?? : 앞에 있는 연산자가 오류이면 []를 실행하라
                    restaurantSearch.append(contentsOf: data)
                case .failure(let error) :
                    print("요청 실패 \(error)")
                    //return .failure(MappingError(from: json, to: RestaurantSearch.self))
                    
                }
                //completion(restaurantSearch)
                completion(restaurantSearch: DataResponse<RestaurantSearch>)
                */
        
        /*
                if let newResponse: [RestaurantSearch] = response.flatMap { json in
                    
                    let value = Mapper<RestaurantSearch>().mapArray(JSONArray: response as! [[String: Any]])
                    return .success(value)
                }
                */
        
                //let value = Mapper<RestaurantSearch>().mapArray(JSONArray: response as! [[String: Any]])
                //return .success(value)

                
                //return .success(value)

                
                /*

                let newResponse: [RestaurantSearch] = response { json in

                    let value = Mapper<RestaurantSearch>().mapArray(JSONArray: response as! [[String: Any]])
                    return .success(value)

                    */
                    /*
                    let value = json as! [[String: Any]]
                    let aaa = JSONArray.flatMap(value)
                    
                    if let post = Mapper<RestaurantSearch>().map(JSONString: json) {
                        return .success(post)
                    }
                    */
                    
                    //let value = json as! [[String: Any]]
 
                    //let value = Mapper<RestaurantSearch>().mapArray(JSONArray: json as! [[String: Any]])
                    //return .success(value)
 
 
                    
                        
                    //if let post = Mapper<RestaurantSearch>().map(JSONString: stringArray) {
                        //return .success(post)
                    //}

                    
                    //if let post = Mapper<RestaurantSearch>().mapArray(JSONArray: json) {
                        //return .success(post)
                    //}
                    
                    /*
                    if let post2 = Mapper<RestaurantSearch>().map(JSON: value) {
                        return .success(post2)
                    }
                    */
                    
                    //let value2 = json as! [[String: Any]]
                    //if let post = Mapper<RestaurantSearch>().mapArray(JSONArray: value2) {
                        //return .success(post)
                    //}

                    
                    
                    /*
                    print("json : \(json)")
                    let value = json as! [[String: Any]]

                    if let post = Mapper<RestaurantSearch>().map(JSONObject: (mapArray(JSONArray: value))) {
                        return .success(post)
                    }; else {
                        return .failure(MappingError(from: json, to: RestaurantSearch.self))
                    }
                    */
                    
                    
                    /*
                    if let value2 = Mapper<RestaurantSearch>().mapArray(JSONArray: value) {
                        if let post = Mapper<RestaurantSearch>().map(JSONObject: value2)) {
                            return .success(post)
                        }; else {
                            return .failure(MappingError(from: json, to: RestaurantSearch.self))
                        }
                    } else {
                        return .failure(MappingError(from: json, to: RestaurantSearch.self))
                    }
                    */
                    
                    
                    //return .failure(MappingError(from: json, to: RestaurantSearch.self))
                //}
                
                //completion(newResponse)

    /*
    static func restaurantSearch(searchText: String, completion: @escaping (DataResponse<RestaurantSearch>) -> Void) {
        let urlString = FixedCommonSet.networkinkBaseUrl + "restaurantSearch"
        let parameters: [String: Any] = [
            "searchText": "벽산",
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            ]
        
        Alamofire.request(urlString, method: .get, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<400)
            .responseJSON { response in
                let newResponse: DataResponse<RestaurantSearch> = response.flatMap { json in
                    print("json : \(json)")
                    if let post = Mapper<RestaurantSearch>().map(JSONObject: json ) {
                        return .success(post)
                    } else {
                        return .failure(MappingError(from: json, to: RestaurantSearch.self))
                    }
                }
                completion(newResponse)
        }
    }
    */
    
    
    
    /*
    static func restaurantSearch(searchText: String, completion: @escaping (DataResponse<RestaurantSearch>) -> Void) {
    //static func restaurantSearch(searchText: String, completion: @escaping (DataResponse<RestaurantSearch2>) -> Void) {
        let urlString = FixedCommonSet.networkinkBaseUrl + "restaurantSearch"
        let parameters: [String: Any] = [
            "searchText": "벽산",
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            ]
        
        Alamofire.request(urlString, method: .get, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<400)
            .responseJSON { response in // 1
                //print(response.request)  // original URL request
                //print(response.response) // URL response
                //print(response.data)     // server data
                //print(response.result)   // result of response serialization
                /*
                guard response.result.isSuccess else {
                    print("Error while fetching tags: \(response.result.error)")
                    //completion([String]())
                    return
                }
                */
                
                //var restaurantSearch: [RestaurantSearch2] = []
                let newResponse: DataResponse<RestaurantSearch> = response.flatMap { json in
                    /*
                    guard let newsResponse = response.result.value as? [[String:String]] else{
                        //print("Error: \(response.result.error)")
                        return
                    }
                    */
                    /*
                    
                    guard let dataArray = response.result.value as? [[String:String]] else{
                        //print("Error: \(response.result.error)")
                        return .failure(MappingError(from: json, to: RestaurantSearch2.self))
                    }
                    //let dataArray = response.result.value as? [[String:String]]
                    var count = 0
                    while count < dataArray.count {
                        let dic = dataArray[count]
                        //print("_id: \(dic["_id"])")
                        restaurantSearch.append(RestaurantSearch2(_id: dic["_id"]!, companyName: dic["companyName"]!, certification: dic["certification"]!, address: dic["address"]!, contactNumber: dic["contactNumber"]!, representative: dic["representative"]!))
                        count = count + 1
                    }
                    */
                    if let restaurantSearch = Mapper<RestaurantSearch>().map(JSONObject: json) {
                        return .success(restaurantSearch)
                    } else {
                        return .failure(MappingError(from: json, to: RestaurantSearch.self))
                    }
                    completion(newResponse)
                }
                
                
                //newResponse: DataResponse<RestaurantSearch>
                
                //completion(restaurantSearch)
                
                
                /*
                let newResponse: DataResponse<RestaurantSearch2> = response.flatMap { json in
                    
                    if let restaurantSearch = Mapper<RestaurantSearch>().map(JSONObject: json) {
                        return .success(restaurantSearch2)
                    }

                    
                    switch response.result {
                    case .success(let value):
                        print("로그인 되어있음!", value)
                    case .failure(let error):
                        print("로그인 안되어있음", error)
                    }
                
                /*
                let newResponse: DataResponse<RestaurantSearch> = response.flatMap { json in
                    print("json : \(json)")
                    
                    let object = (JSONObject: json())
                    print("object : \(object)")

                    let json = JSON(json)
                    json.toString()
                */
                
                    /*
                    if let restaurantSearch = Mapper<RestaurantSearch>().map(JSONObject: json) {
                        return .success(restaurantSearch)
                    }
                    */
                    
                    /*
                    var data: [Any]?
                    do {
                        data = try JSONSerialization.jsonObject(json as [Any]?)
                    } catch {
                        print(error)
                    }
                    
                    print("data : \(data)")
                    */
                    
                    /*
                    ["name"] as? String {
                        //names.append(name)
                    }
                    */
                    
                    return .failure(MappingError(from: json, to: RestaurantSearch.self))
                    //return .success(restaurantSearch)
                    /*
                    if let restaurantSearch = Mapper<RestaurantSearch>().map(JSONObject: json) {
                        return .success(restaurantSearch)
                    } else {
                        return .failure(MappingError(from: json, to: RestaurantSearch.self))
                    }
                    */
                }
                completion(newResponse)
                */
                
                /*
                switch response.result {
                case .success(let value) :
                    guard let json = value as? [[String: Any]] else {break}
                    let restaurantSearchNew = [RestaurantSearch](JSONArray: json) ?? [] //?? : 앞에 있는 연산자가 오류이면 []를 실행하라
                    completion(restaurantSearchNew)
                    //self.restaurantSearch.append(contentsOf: restaurantSearchList)
                    //self.tableView.reloadData()
                case .failure(let error) :
                    //print("요청 실패 \(error)")
                    
                }
                */
                
                /*
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    
                    var jsonArray = JSON as? NSMutableArray
                    //var newArray: Array<String> = []
                    
                    for item in jsonArray! {
                        print(item)
                        //let string = item["name"]?
                        //print("String is \(string!)")
                        
                        //self.newArray.append(string! as! String)
                    }
                    
                    //print("New array is \(newArray)")
                    
                    //self.tableView.reloadData()
                    //print("JSON: \(JSON)")
                }
 */
        //}
        
        /*
        Alamofire.request(urlString, method: .get, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<400)
            .responseJSON{ response in
            switch response.result{
            case .success (let data):
                print("data: \(data)")
                
                var name = data[0]
                
                /*
                guard let value = data as? JSON,
                    let eventsArrayJSON = value["ABDC"] as? [JSON]
                    else { fatalError() }
                let struct_name = [Struct_Name].from(jsonArray: eventsArrayJSON)//the JSON deserialization is done here, after this line you can do anything with your JSON
                for i in 0 ..< Int((struct_name?.count)!) {
                    print((struct_name?[i].IJ!)!)
                    print((struct_name?[i].KL!)!)
                }
                */
                
                break
                
            case .failure(let error):
                print("Error: \(error)")
                break
            }
        }
        */
        
        /*
        Alamofire.request(urlString, method: .get, parameters: parameters, headers: headers)
                 .validate(statusCode: 200..<400)
                 .responseJSON { response in
                    let newResponse: DataResponse<RestaurantSearch> = response
                        .flatMap { json in
                        if let restaurantSearch = Mapper<RestaurantSearch>().map(JSONObject: json) {
                            return .success(restaurantSearch)
                        } else {
                            return .failure(MappingError(from: json, to: RestaurantSearch.self))
                        }
                    }
                completion(newResponse)
        }
        */
    }
    */
    


