//
//  FixedBaseUrl.swift
//  JJam
//
//  Created by admin on 2018. 1. 2..
//  Copyright © 2018년 admin. All rights reserved.
//

struct FixedBaseUrl {
    //Server URL
    //static let BaseUrl = "http://127.0.0.1:3000/"             //local
    //static let BaseUrl = "http://192.168.2.30:3000/"          //local WIFI
    //static let BaseUrl = "http://106.245.251.59:3000/"        //조은 Server
    //static let BaseUrl = "http://106.245.251.60:3000/"        //local WIFI
    static let BaseUrl = "http://13.125.115.164:3000/"        //AWS 2018

    
    /* ============== 조회 ============== */
    //운영자 공지사항 조회
    static let managerNoticeSearch = BaseUrl + "managerNoticeSearch"
    //관심 식당
    static let restaurantSearch = BaseUrl + "restaurantSearch"
    //식당 인증 & 공지사항
    static let restaurantInfo = BaseUrl + "restaurantInfo"
    //식단(오늘,계획,지난,사진)
    static let mealSearch = BaseUrl + "mealSearch"
    //식단 맛있어요 카운터
    static let mealLikeCount = BaseUrl + "mealLikeCount"
    //식단 맛있어요 설정/해제
    static let mealLike = BaseUrl + "mealLike"
    //식단 등록 카운터를 이용한 전면 배너 광고 처리
    static let mealBannerCheck = BaseUrl + "mealBannerCheck"
    //로그인
    static let restaurantLogin = BaseUrl + "restaurantLogin"
    //회원 정보 조회
    static let restaurantMember = BaseUrl + "restaurantMember"
    //식당 항목(Group) 조회
    static let restaurantGroup = BaseUrl + "restaurantGroup"
    //식당 요청, 문의 게시판
    static let boardSearch = BaseUrl + "boardSearch"

    
    
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
    //식당 요청, 문의 게시판 등록
    static let boardWrite = BaseUrl + "boardWrite"
    //식당 요청, 문의 게시판 수정
    static let boardEdit = BaseUrl + "boardEdit"
    //식당 요청, 문의 게시판 삭제
    static let boardDel = BaseUrl + "boardDel"

}
