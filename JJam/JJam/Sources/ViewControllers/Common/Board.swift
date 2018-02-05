//
//  Board.swift
//  JJam
//
//  Created by admin on 2018. 1. 3..
//  Copyright © 2018년 admin. All rights reserved.
//


import UIKit

final class Board: UIViewController {
    
    //MARK: Properties
    fileprivate var didSetupConstraints = false
    fileprivate var boardInfo: [BoardInfo] = []
    fileprivate var restaurant_Id = ""
    fileprivate var uniqueId = ""
    

    //MARK: Constants
    fileprivate struct Metric {
        static let commonOffset = CGFloat(7)
    }
    
    //MARK: UI
    fileprivate let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    fileprivate let tableView = UITableView(frame: .zero, style: .plain)
    
    
    //NotificationCenter에 등록된 옵저버의 타겟 객체가 소멸
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: init
    init(title :String, restaurant_Id: String) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
        self.tabBarItem.image = UIImage(named: "tab-board")
        self.tabBarItem.selectedImage = UIImage(named: "tab-board-selected")
        
        if restaurant_Id == "" {
            self.uniqueId = UIDevice.current.identifierForVendor!.uuidString
            self.restaurant_Id = ""
        } else {
            self.uniqueId = ""
            self.restaurant_Id = restaurant_Id
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        //scroll의 내부 여백 발생시 사용()
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationController?.navigationBar.barTintColor = .orange
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "편집",
            style: .done,
            target: self,
            action: #selector(editButtonDidTap)
        )
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "문의 하기",
            style: .done,
            target: self,
            action: #selector(addButtonDidTap)
        )
        self.navigationItem.rightBarButtonItem?.tintColor = .white

        UICommonSetLoading(self.activityIndicatorView)
        
        //문의 또는 식당요청 게시판 삭제
        //boardSearch();
        
        //관심 식당
        self.tableView.register(BoardCell.self, forCellReuseIdentifier: "boardCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.activityIndicatorView)
        //updateViewConstraints 자동 호출
        self.view.setNeedsUpdateConstraints()
        
    }
    
    //MARK: View Life Cycle (화면이 다시 보이면)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //문의 또는 식당요청 게시판 삭제
        boardSearch();
    }
    
    //XIB로 view 를 생성하지 않고 view을 로드할때 사용된다
    override func loadView() {
        super.loadView()
    }
    
    
    //MARK: 애플 추천 방식으로 한번만 화면을 그리도록 한다.
    //setNeedsUpdateConstraints() 필요
    override func updateViewConstraints() {
        if !self.didSetupConstraints {
            self.didSetupConstraints = true
            self.activityIndicatorView.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            self.tableView.snp.makeConstraints { make in
                make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(Metric.commonOffset)
                make.left.right.equalToSuperview()
                make.bottom.equalTo(self.view.snp.bottom)
            }
        }
        super.updateViewConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: ACTION
    func editButtonDidTap() {
        guard !self.boardInfo.isEmpty else { return }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "완료",
            style: .done,
            target: self,
            action: #selector(doneButtonDidTap)
        )
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        self.tableView.setEditing(true, animated: true)
    }
    
    func doneButtonDidTap() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "편집",
            style: .done,
            target: self,
            action: #selector(editButtonDidTap)
        )
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        self.tableView.setEditing(false, animated: true)
    }
    
    func addButtonDidTap() {
        //UI 버그 처리
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "문의 하기",
            style: .done,
            target: self,
            action: #selector(addButtonDidTap)
        )
        self.navigationItem.rightBarButtonItem?.tintColor = .white

        let newBoardInfo = [BoardInfo](JSONArray: [["board_Id": "",
                                                    "restaurant_Id": restaurant_Id,     //필수
                                                    "uniqueId": uniqueId,               //필수
                                                    "division": "",
                                                    "title": "",
                                                    "contents": "",
                                                    "answer": "",
                                                    "message": ""]])                    //필수
        
        let boardDetail = BoardDetail(boardInfo: newBoardInfo)
        self.navigationController?.pushViewController(boardDetail, animated: true)
    }
    
    //문의 또는 식당요청 게시판 삭제
    func boardSearch() {
        UICommonSetLoadingService(self.activityIndicatorView, service: true)
        CommonNetWorking.boardSearch(restaurant_Id :self.restaurant_Id, uniqueId: self.uniqueId) { [weak self] response in
            guard let `self` = self else { return }
            if response.count > 0 {
                UICommonSetLoadingService(self.activityIndicatorView, service: false)
                //iOS는 메시지 처리 하지 않음
                let message = response[0].message
                if message != nil {
                    if message != "문의 내용이 없습니다." {
                        let alertController = UIAlertController(
                            title: "확인",
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
                    return
                }
            }
            self.boardInfo = response
            self.tableView.reloadData()
        }
    }
    
    //식단 삭제
    func boardDel(board_Id: String) {
        UICommonSetLoadingService(self.activityIndicatorView, service: true)
        CommonNetWorking.boardDel(board_Id: board_Id) { [weak self] response in
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
                        title: "확인",
                        style: .default) { _ in
                            // 확인 후 작업
                            if message == "삭제가 완료되었습니다." {
                                self.doneButtonDidTap()
                                self.boardSearch()
                            }
                    }
                    alertController.addAction(alertConfirm)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
            }
        }
    }
}

extension Board: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.boardInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "boardCell", for: indexPath) as! BoardCell
        cell.configure(boardInfo: self.boardInfo[indexPath.item])
        return cell
    }
}

extension Board: UITableViewDelegate {
    //선택
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("\(indexPath)가 선택!")
        let boardDetail = BoardDetail(boardInfo: [self.boardInfo[indexPath.row]])
        self.navigationController?.pushViewController(boardDetail, animated: true)
    }
    
    //삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let message = "(" + self.boardInfo[indexPath.row].division + ") " + self.boardInfo[indexPath.row].title + "\n" +
        "을(를) 목록에서 삭제 하시겠습니까?"
        
        let alertController = UIAlertController(
            title: self.title,
            message: message,
            preferredStyle: .alert
        )
        let alertCancel = UIAlertAction(
            title: "취소",
            style: .default) { _ in
                // 확인 후 작업
        }
        let alertConfirm = UIAlertAction(
            title: "삭제",
            style: .default) { _ in
                // 확인 후 작업
                self.boardDel(board_Id: self.boardInfo[indexPath.row].board_Id)
        }
        alertController.addAction(alertCancel)
        alertController.addAction(alertConfirm)
        self.present(alertController, animated: true, completion: nil)
    }
    
    /*
    //위치 이동
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var boardInfo = self.boardInfo
        let removeBoardInfo = boardInfo.remove(at: sourceIndexPath.row)
        boardInfo.insert(removeBoardInfo, at: destinationIndexPath.row)
        self.boardInfo = boardInfo
    }
    */
    
    //cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SuperConstants.tableViewCellHeight
    }
}

