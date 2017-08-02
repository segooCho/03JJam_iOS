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
    //식당 category 항목(Group) 조회
    static let restaurantGroup = BaseUrl + "restaurantGroup"
    //이미지 경로
    static let uploads = BaseUrl + "uploads"
    
    
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
}

//식단 등록 category
struct categoryArray {
    static var location: NSMutableArray = []
    static var division: NSMutableArray = []
    static var stapleFood: NSMutableArray = []
    static var soup: NSMutableArray = []
    static var sideDish: NSMutableArray = []
    static var dessert: NSMutableArray = []
}




struct SuperConstants {
    //tableView 높이 지정
    static let tableViewCellHeight = CGFloat(50)
    static let tableViewCellHeight70 = CGFloat(70)
    static let tableViewCellHeight100 = CGFloat(100)
    
    //Loding delayTime(TableView 바인딩되는 시간을 인위적으로 기다려야 한다.)
    static let msgDelayInSeconds = 0.5
    static let tableViewReloadDelayInSeconds = 1.0
    
    //image 사이즈 조정
    static let tableViewImageSize = CGFloat(57)
    static let imageSize = CGFloat(300)
    
    static let JJamUserDefaultsKeyInterestRestaurantList = "JJamUserDefaultsKeyInterestRestaurantList"
    static let JJamUserDefaultsKeyRestaurantGroup = "JJamUserDefaultsKeyRestaurantGroup"
}

//MARK: Constants
struct Font {
    static let font16 = UIFont.systemFont(ofSize: 16)
}

//mealDetail 뷰 기능 설정(보기, 수정, 등록)
var mealDetailTuple = (editMode: false, writeMode: false)
                    //editMode: false,  writeMode: false    => 일반 사용자 식단 보기
                    //editMode: true,   writeMode: false    => 업체 사용자 식단 수정
                    //editMode: true,   writeMode: true     => 업체 사용자 신규 식단

func setMealDetailTuple(_ editMode: Bool, _ writeMode: Bool) {
    mealDetailTuple.editMode = editMode
    mealDetailTuple.writeMode = writeMode
}
