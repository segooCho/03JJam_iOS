//
//  BoardDetail.swift
//  JJam
//
//  Created by admin on 2018. 1. 3..
//  Copyright © 2018년 admin. All rights reserved.
//


import UIKit
import DownPicker

final class BoardDetail: UIViewController {
    //MARK: Properties
    fileprivate var didSetupConstraints = false
    fileprivate var boardInfo: [BoardInfo] = []

    //MARK: Constants
    fileprivate struct Metric {
        static let commonOffset = CGFloat(7)
        static let commonOffset4 = CGFloat(4)
    }
    
    // MARK: UI
    fileprivate let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    fileprivate let tableView = UITableView(frame: .zero, style: .plain)

    //NotificationCenter에 등록된 옵저버의 타겟 객체가 소멸
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: init
    init(boardInfo: [BoardInfo]) {
        self.boardInfo = boardInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "게시글"
        
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
        
        self.tableView.register(BoardDetailCell.self, forCellReuseIdentifier: "boardDetailCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(self.tableView)

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
            //tableView
            self.tableView.snp.makeConstraints { make in
                make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(Metric.commonOffset)
                make.left.right.bottom.equalToSuperview()
                make.bottom.equalTo(self.bottomLayoutGuide.snp.top).offset(-Metric.commonOffset4)
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
            self.tableView.contentInset.bottom = keyboardVisibleHeight
            self.tableView.scrollIndicatorInsets.bottom = keyboardVisibleHeight
            
            // 키보드가 보여지는 경우 메시지 셀로 스크롤
            if keyboardVisibleHeight > 0 {
                let indexPath = IndexPath(row: 0, section: 0) //메시지 셀
                self.tableView.scrollToRow(at: indexPath, at: .none, animated: false)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: ACTION
    func cancelButtonDidTap() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func addButtonDidTap() {
        let alertController = UIAlertController(
            title: self.title,
            message: "저장 하시겠습니까?",
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
                //self.restaurantNoticeEdit()
                
        }
        alertController.addAction(alertCancel)
        alertController.addAction(alertConfirm)
        self.present(alertController, animated: true, completion: nil)
    }
}


extension BoardDetail: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "boardDetailCell", for: indexPath) as! BoardDetailCell
        cell.configure(boardInfo: self.boardInfo[0])
        return cell
    }
}

extension BoardDetail: UITableViewDelegate {
    //cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BoardDetailCell.height()
    }
}

