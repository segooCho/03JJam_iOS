//
//  FixedValues.swift
//  JJam
//
//  Created by admin on 2017. 7. 18..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

let osVer = "iOS"
let appVer = "1.001"
let appName = "막내야 오늘 뭐야?"

//MARK: SuperConstants
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
}

//MARK: Font
struct Font {
    static let font12 = UIFont.systemFont(ofSize: 12)   //segmentedControl BusinessUsersMenuManagement 에서만 사용
    static let font16 = UIFont.systemFont(ofSize: 16)   //전체 사용 폰트
}

//netWorkingErrorMessage
let netWorkingErrorMessage:[String:String] = ["message": "네트워크 통신에 문제가 발생하여 데이터 요청 작업을 실패했습니다.\n프로그램 업데이트 또는 Wi-Fi 연결 상태를 확인하세요."]
let netWorkingErrorMessageEncodingError:[String:String] = ["message": "네트워크 통신에 문제가 발생하여 데이터 요청 작업을 실패했습니다.\n프로그램 업데이트 또는 Wi-Fi 연결 상태를 확인하세요.(encodingError)"]
let fixedNotice = "네트워크 통신에 문제가 발생하여 데이터 요청 작업을 실패했습니다.\n프로그램 업데이트 또는 Wi-Fi 연결 상태를 확인하세요."


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
