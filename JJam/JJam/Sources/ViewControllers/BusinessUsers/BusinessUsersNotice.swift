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
    fileprivate let restaurant_Id: String
    fileprivate var didSetupConstraints = false
    //fileprivate var businessUsersRestaurantNotice:String!

    //MARK: Constants
    fileprivate struct Metric {
        static let commonMid = CGFloat(10)
        static let commonOffset = CGFloat(7)
    }
    
    // MARK: UI
    fileprivate let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    fileprivate let textView = UITextView()
    
    //NotificationCenter에 등록된 옵저버의 타겟 객체가 소멸
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: init
    init(restaurant_Id: String) {
        self.restaurant_Id = restaurant_Id
        super.init(nibName: nil, bundle: nil)
        
        //식당 인증 & 공지 사항
        restaurantInfo()

        /*
        //데이터 임시 처리
        self.businessUsersRestaurantNotice = "공지사항\n안녕하세요. 한라시그마 구내식당 입니다.\n*월요일 ~ 금요일 까지 영업합니다.\n*토요일, 일요일, 공휴일은 휴무입니다.\n\n\n\n감사합니다."
        */
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
        
        UICommonSetLoading(self.activityIndicatorView)
        UICommonSetTextViewEnable(self.textView, placeholderText: "")
        self.view.addSubview(self.textView)
        self.view.addSubview(self.activityIndicatorView)
        //updateViewConstraints 자동 호출
        self.view.setNeedsUpdateConstraints()
    }
    
    //MARK: 애플 추천 방식으로 한번만 화면을 그리도록 한다.
    //setNeedsUpdateConstraints() 필요
    override func updateViewConstraints() {
        if !self.didSetupConstraints {
            self.didSetupConstraints = true
            self.activityIndicatorView.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            self.textView.snp.makeConstraints { make in
                make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(Metric.commonOffset)
                make.left.equalTo(Metric.commonMid)
                make.right.equalTo(-Metric.commonMid)
                make.bottom.equalTo(self.bottomLayoutGuide.snp.top).offset(-Metric.commonOffset)
            }
        }
        
        //키보드에 숨겨지는 입력처리
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillChangeFrame),
            name: .UIKeyboardWillChangeFrame,
            object: nil
        )
        
        super.updateViewConstraints()
    }
    
    // MARK: Notification
    func keyboardWillChangeFrame(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect,
            let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval
            else { return }
        let keyboardVisibleHeight = UIScreen.main.bounds.height - keyboardFrame.origin.y
        UIView.animate(withDuration: duration) {
            self.textView.contentInset.bottom = keyboardVisibleHeight
            self.textView.scrollIndicatorInsets.bottom = keyboardVisibleHeight
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: ACTION
    //식당 인증 & 공지 중 공지만 사용
    func restaurantInfo() {
        UICommonSetLoadingService(self.activityIndicatorView, service: true)
        CommonNetWorking.restaurantInfo(restaurant_Id: self.restaurant_Id) { [weak self] response in
            guard let `self` = self else { return }
            if response.count > 0 {
                UICommonSetLoadingService(self.activityIndicatorView, service: false)
                let message = response[0].message
                if message != nil {
                    let alertController = UIAlertController(
                        title: self.title,
                        message: message,
                        preferredStyle: .alert
                    )
                    let alertConfirm = UIAlertAction(
                        title: "이전 화면 돌아가기",
                        style: .default) { _ in
                            // 확인 후 작업
                            _ = self.navigationController?.popViewController(animated: true)
                    }
                    alertController.addAction(alertConfirm)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    //공지사항
                    let notice = response[0].notice
                    //self.textView.text = notice?.replacingOccurrences(of: "\\n", with: "\n")
                    self.textView.text = notice
                    //self.businessUsersRestaurantNotice = response[0].notice
                }
            }
        }
    }

    //식당 인증 & 공지 중 공지만 사용
    func restaurantNoticeEdit() {
        UICommonSetLoadingService(self.activityIndicatorView, service: true)
        BusinessUsersNetWorking.restaurantNoticeEdit(restaurant_Id: self.restaurant_Id, notice: self.textView.text!) { [weak self] response in
            guard let `self` = self else { return }
            if response.count > 0 {
                UICommonSetLoadingService(self.activityIndicatorView, service: false)
                let message = response[0].message
                if message != nil {
                    let alertController = UIAlertController(
                        title: self.title,
                        message: message,
                        preferredStyle: .alert
                    )
                    let alertPage = UIAlertAction(
                        title: "이전 화면 돌아가기",
                        style: .default) { _ in
                            // 확인 후 작업
                            _ = self.navigationController?.popViewController(animated: true)
                    }
                    let alertConfirm = UIAlertAction(
                        title: "확인",
                        style: .default) { _ in
                            // 확인 후 작업
                    }
                    alertController.addAction(alertPage)
                    alertController.addAction(alertConfirm)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    func cancelButtonDidTap() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func addButtonDidTap() {
        guard let notice = self.textView.text, !notice.isEmpty else {
            UICommonSetShakeTextView(self.textView)
            return
        }
        let alertController = UIAlertController(
            title: self.title,
            message: "공지 사항을 저장하시겠습니까?",
            preferredStyle: .alert
        )
        let alertCancel = UIAlertAction(
            title: "취소",
            style: .default) { _ in
                // 확인 후 작업
        }
        let alertConfirm = UIAlertAction(
            title: "저장",
            style: .default) { _ in
                // 확인 후 작업
                self.restaurantNoticeEdit()
                
        }
        alertController.addAction(alertCancel)
        alertController.addAction(alertConfirm)
        self.present(alertController, animated: true, completion: nil)

        
    }
}
