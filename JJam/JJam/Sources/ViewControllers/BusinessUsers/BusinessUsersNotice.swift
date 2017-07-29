//
//  BusinessUsersNotice.swift
//  JJam
//
//  Created by admin on 2017. 7. 20..
//  Copyright © 2017년 admin. All rights reserved.
//


import UIKit

final class BusinessUsersNotice: UIViewController {
    //MARK: Properties
    var didSetupConstraints = false
    var businessUsersRestaurantId:String!
    var businessUsersRestaurantNotice:String!

    //MARK: Constants
    fileprivate struct Metric {
        static let commonMid = CGFloat(10)
        static let commonOffset = CGFloat(7)
    }
    
    // MARK: UI
    fileprivate let textView = UITextView()
    
    //MARK: init
    init(businessUsersRestaurantId: String) {
        self.businessUsersRestaurantId = businessUsersRestaurantId
        super.init(nibName: nil, bundle: nil)
        
        //데이터 임시 처리
        self.businessUsersRestaurantNotice = "공지사항\n안녕하세요. 한라시그마 구내식당 입니다.\n*월요일 ~ 금요일 까지 영업합니다.\n*토요일, 일요일, 공휴일은 휴무입니다.\n\n\n\n감사합니다."
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "공지사항"
        
        //scroll의 내부 여백 발생시 사용()
        self.automaticallyAdjustsScrollViewInsets = false

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelButtonDidTap)
        )
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonDidTap)
        )
        
        self.textView.text = self.businessUsersRestaurantNotice
        UICommonSetTextViewEnable(self.textView, placeholderText: "공지 사항")
        //self.textView.addTarget(self, action: #selector(textFieldDidChangeText), for: .editingChanged)
        self.view.addSubview(self.textView)
        //updateViewConstraints 자동 호출
        self.view.setNeedsUpdateConstraints()
    }
    
    //MARK: 애플 추천 방식으로 한번만 화면을 그리도록 한다.
    //setNeedsUpdateConstraints() 필요
    override func updateViewConstraints() {
        if !self.didSetupConstraints {
            self.didSetupConstraints = true
            self.textView.snp.makeConstraints { make in
                make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(Metric.commonOffset)
                make.left.equalTo(Metric.commonMid)
                make.right.equalTo(-Metric.commonMid)
                make.bottom.equalToSuperview().offset(-Metric.commonOffset)
            }
        }
        super.updateViewConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    func cancelButtonDidTap() {
        AppDelegate.instance?.BusinessUsersTabBarScreen(selectIndex: 2)
    }
    
    func textFieldDidChangeText(_ textField: UITextField) {
        textField.textColor = .black
    }
    
    func addButtonDidTap() {
        guard let notice = self.textView.text, !notice.isEmpty else {
            UICommonSetShakeTextView(self.textView)
            return
        }
        //TODO ::통신 처리
        AppDelegate.instance?.BusinessUsersTabBarScreen(selectIndex: 2)
    }
}
