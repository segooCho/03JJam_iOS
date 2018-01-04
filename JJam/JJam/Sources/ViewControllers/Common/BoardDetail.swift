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
    fileprivate var boardCellInfo: [BoardCellInfo] = []

    
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
        
        if self.boardInfo[0].answer != "" {
            let alertController = UIAlertController(
                title: self.title,
                message: "답변이 완료된 게시글은 수정이 불가능합니다.",
                preferredStyle: .alert
            )
            let alertConfirm = UIAlertAction(
                title: "확인",
                style: .default) { _ in
            }
            alertController.addAction(alertConfirm)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        // TableView[0] 에서 입력 값 가지고 오기
        // UI는 직접 처리 불가, struct만 접근 가능 제약이 많음... 병맛으로 처리 했음
        // contentView 에서는 self.present 처리도 불가능
        let index = IndexPath(row: 0, section: 0)
        let cell: BoardDetailCell = self.tableView.cellForRow(at: index) as! BoardDetailCell
        
        //struct tableViewCellSignUp 값 저장
        let message = cell.setInputData()

        if message.isEmpty {
            var tmpMessage:String = ""
            if self.boardInfo[0].board_Id == nil {
                tmpMessage = "게시글을 저장 하시겠습니까?"
            } else {
                tmpMessage = "게시글을 수정 하시겠습니까?"
            }
            
            let alertController = UIAlertController(
                title: self.title,
                message: tmpMessage,
                preferredStyle: .alert
            )
            let alertCancel = UIAlertAction(
                title: "취소",
                style: .default) { _ in
                    // 확인 후 작업
                    return
            }
            let alertConfirm = UIAlertAction(
                title: "저장",
                style: .default) { _ in
                    // 확인 후 작업
                    self.boardSave()
                    
            }
            alertController.addAction(alertCancel)
            alertController.addAction(alertConfirm)
            self.present(alertController, animated: true, completion: nil)
        } else {
            //TODO : 입력값 처리
            let alertController = UIAlertController(
                title: self.title,
                message: message,
                preferredStyle: .alert
            )
            let alertConfirm = UIAlertAction(
                title: "확인",
                style: .default) { _ in
                    // 확인 후 작업
            }
            alertController.addAction(alertConfirm)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func boardSave() {
        self.boardCellInfo.removeAll()
        self.boardCellInfo = BoardDetailCell.tableViewCellBoardInfo.boardCellInfo
        if boardCellInfo.count < 0 {
            let alertController = UIAlertController(
                title: self.title,
                message: "등록 처리 중 오류가 발생했습니다.",
                preferredStyle: .alert
            )
            let alertConfirm = UIAlertAction(
                title: "확인",
                style: .default) { _ in
                    // 확인 후 작업
            }
            alertController.addAction(alertConfirm)
            self.present(alertController, animated: true, completion: nil)
            return
        } else {
            boardSaveNetWorking()
        }
    }
    
    func boardSaveNetWorking() {
        UICommonSetLoadingService(self.activityIndicatorView, service: true)
        CommonNetWorking.boardEditAndWrite(boardCellInfo: self.boardCellInfo) { [weak self] response in
                guard let `self` = self else { return }
                if response.count > 0 {
                    //Notification 포함 작동 중
                    UICommonSetLoadingService(self.activityIndicatorView, service: false)
                    let message = response[0].message //무조건 리턴 메시지 발생함
                    if message != nil {
                        if message == "저장이 완료되었습니다." || message == "수정이 완료되었습니다." {
                            //OK
                            let alertController = UIAlertController(
                                title: self.title,
                                message: message,
                                preferredStyle: .alert
                            )
                            let alertLoginScreen = UIAlertAction(
                                title: "이전 페이지 이동",
                                style: .default) { _ in
                                    //이전 페이지
                                    _ = self.navigationController?.popViewController(animated: true)
                            }
                            alertController.addAction(alertLoginScreen)
                            UICommonSetLoadingService(self.activityIndicatorView, service: false)
                            self.present(alertController, animated: true, completion: nil)
                            
                        } else {
                            //Error 메시지
                            let alertController = UIAlertController(
                                title: self.title,
                                message: message,
                                preferredStyle: .alert
                            )
                            let alertConfirm = UIAlertAction(
                                title: "확인",
                                style: .default) { _ in
                                    //확인 후 처리
                            }
                            alertController.addAction(alertConfirm)
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                }
        }
    }
}


extension BoardDetail: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "boardDetailCell", for: indexPath) as! BoardDetailCell
        cell.configure(boardInfo: [self.boardInfo[0]])
        return cell
    }
}

extension BoardDetail: UITableViewDelegate {
    //cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BoardDetailCell.height()
    }
}
