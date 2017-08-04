//
//  FixedCommonSet.swift
//  JJam
//
//  Created by admin on 2017. 7. 18..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

//MARK: Constants
struct Url {
    //Server URL
    static let BaseUrl = "http://127.0.0.1:3000/"         //local
    //static let BaseUrl = "http://106.245.251.59:3000/"  //조은 Server
    
    /* ============== 조회 ============== */
    //관심 식당
    static let restaurantSearch = BaseUrl + "restaurantSearch"
    //식당 인증 & 공지사항
    static let restaurantInfo = BaseUrl + "restaurantInfo"
    //식단(오늘,계획,지난,사진)
    static let mealSearch = BaseUrl + "mealSearch"
    //로그인
    static let restaurantLogin = BaseUrl + "restaurantLogin"
    //회원 정보 조회
    static let restaurantMember = BaseUrl + "restaurantMember"
    //식당 항목(Group) 조회
    static let restaurantGroup = BaseUrl + "restaurantGroup"

    
    /* ============== 이미지 ============== */
    //이미지 경로
    static let uploads = BaseUrl + "uploads"
    static let uploadsSignUp = BaseUrl + "uploadsSignUp"
    
    
    /* ============== 등록 & 수정 ============== */
    //회원 가입
    static let restaurantSignUp = BaseUrl + "restaurantSignUp"
    //식단 등록
    static let mealWrite = BaseUrl + "mealWrite"
    //식단 수정
    static let mealEdit = BaseUrl + "mealEdit"
    //식단 삭제
    static let mealDel = BaseUrl + "mealDel"
    //식당 공지사항 수정
    static let restaurantNoticeEdit = BaseUrl + "restaurantNoticeEdit"
    //식당 항목(Group) 추가
    static let restaurantGroupAdd = BaseUrl + "restaurantGroupAdd"
    //식당 항목(Group) 삭제
    static let restaurantGroupDel = BaseUrl + "restaurantGroupDel"
    //회원 수정
    static let restaurantEdit = BaseUrl + "restaurantEdit"

}

//식단 항목(Group)
struct groupArray {
    static var location: NSMutableArray = []        //위치
    static var division: NSMutableArray = []        //구분
    static var stapleFood: NSMutableArray = []      //주식(밥,면)
    static var soup: NSMutableArray = []            //국
    static var sideDish: NSMutableArray = []        //반찬
    static var dessert: NSMutableArray = []         //후식
}


struct SuperConstants {
    //tableView 높이 지정
    static let tableViewCellHeight = CGFloat(50)
    static let tableViewCellHeight70 = CGFloat(70)
    static let tableViewCellHeight100 = CGFloat(100)
    
    //Loding delayTime(TableView 바인딩되는 시간을 강제로 기다려준다.)
    static let msgDelayInSeconds = 0.5
    static let tableViewReloadDelayInSeconds = 1.0
    
    //image 사이즈 조정
    static let tableViewImageSize = CGFloat(57)
    static let imageSize = CGFloat(300)                 //600 x 600 사이즈로 변환
    
    static let JJamUserDefaultsKeyInterestRestaurantList = "JJamUserDefaultsKeyInterestRestaurantList"
}

//MARK: Constants
struct Font {
    static let font12 = UIFont.systemFont(ofSize: 12)   //segmentedControl BusinessUsersMenuManagement 에서만 사용
    static let font16 = UIFont.systemFont(ofSize: 16)   //전체 사용 폰트
}

//netWorkingErrorMessage
let netWorkingErrorMessage:[String:String] = ["message": "네트워크 통신에 문제가 발생하여 데이터 요청 작업을 실패했습니다."]
let netWorkingErrorMessageEncodingError:[String:String] = ["message": "네트워크 통신에 문제가 발생하여 데이터 요청 작업을 실패했습니다.(encodingError)"]


//controlTuple 뷰 기능 설정(보기, 수정, 등록)
var controlTuple = (editMode: false, writeMode: false)
/**
editMode: false, writeMode: false    => 일반 사용자 식단 보기
editMode: true,  writeMode: false    => 업체 사용자 식단 수정
editMode: true,  writeMode: true     => 업체 사용자 신규 식단
editMode: false, writeMode: false    => 회원 가입
 
**/
func setControlTuple(editMode: Bool, writeMode: Bool) {
    controlTuple.editMode = editMode
    controlTuple.writeMode = writeMode
}
