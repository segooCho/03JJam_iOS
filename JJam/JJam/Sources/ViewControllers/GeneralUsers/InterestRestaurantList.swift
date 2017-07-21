//
//  InterestRestaurantList.swift
//  JJam
//
//  Created by admin on 2017. 7. 12..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

final class InterestRestaurantList: UIViewController {
    
    //MARK: Properties
    var didSetupConstraints = false
    var interestRestaurant: [InterestRestaurant] = [] /*{
        didSet {
            self.saveAll()
        }
    }
    */
    fileprivate let fixedNotice = "www.JJam.com 에서 가맹점 검색 및 가맹점 요청이 가능합니다."

    //MARK: UI
    fileprivate let textView = UITextView()
    fileprivate let tableView = UITableView(frame: .zero, style: .plain)
    
    //MARK: init
    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "오늘의 짬"
        self.tabBarItem.image = UIImage(named: "tab-restaurant")
        self.tabBarItem.selectedImage = UIImage(named: "tab-restaurant-selected")
        
        //데이터 임시 처리
        self.interestRestaurant.append(InterestRestaurant(id: "1", companyName: "한라시그마 구내식당"))
        self.interestRestaurant.append(InterestRestaurant(id: "2", companyName: "벽산 구내식당"))
        self.interestRestaurant.append(InterestRestaurant(id: "3", companyName: "조은 함바"))
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

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(editButtonDidTap)
        )
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonDidTap)
        )
        
        //공지사항
        self.textView.text = self.fixedNotice
        UICommonSetTextViewDisable(self.textView)
        self.view.addSubview(self.textView)

        //관심 식당
        self.tableView.register(InterestRestaurantListCell.self, forCellReuseIdentifier: "interestRestaurantListCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(self.tableView)
        //updateViewConstraints 자동 호출
        self.view.setNeedsUpdateConstraints()
    }
    
    //MARK: 애플 추천 방식으로 한번만 화면을 그리도록 한다. 
    //setNeedsUpdateConstraints() 필요
    override func updateViewConstraints() {
        if !self.didSetupConstraints {
            self.didSetupConstraints = true
            self.textView.snp.makeConstraints { make in
                make.left.equalTo(10)
                make.right.equalTo(-10)
                make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(5)
                make.height.equalTo(50)
            }
            self.tableView.snp.makeConstraints { make in
                make.top.equalTo(self.textView.snp.bottom).offset(3)
                make.left.right.height.equalToSuperview()
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
        guard !self.interestRestaurant.isEmpty else { return }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonDidTap)
        )
        self.tableView.setEditing(true, animated: true)
    }
    
    func doneButtonDidTap() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(editButtonDidTap)
        )
        self.tableView.setEditing(false, animated: true)
    }
    
    func addButtonDidTap() {
        AppDelegate.instance?.RestaurantListSearchScreen()
    }
}


