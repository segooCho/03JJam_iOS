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
    
    
    //NotificationCenter에 등록된 옵저버의 타겟 객체가 소멸
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: init
    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "오늘의 짬"
        self.tabBarItem.image = UIImage(named: "tab-restaurant")
        self.tabBarItem.selectedImage = UIImage(named: "tab-restaurant-selected")
        
        //데이터 임시 처리
        self.interestRestaurant.append(InterestRestaurant(_id: "1", companyName: "한라시그마 구내식당"))
        self.interestRestaurant.append(InterestRestaurant(_id: "2", companyName: "벽산 구내식당"))
        self.interestRestaurant.append(InterestRestaurant(_id: "3", companyName: "조은 함바"))
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
    
    //XIB로 view 를 생성하지 않고 view을 로드할때 사용된다
    override func loadView() {
        super.loadView()
        //NotificationCenter에 등록
        NotificationCenter.default.addObserver(self, selector: #selector(interestRestaurantDidAdd), name: .interestRestaurantDidAdd, object: nil)
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
        //AppDelegate.instance?.RestaurantListSearchScreen()
        let restaurantListSearch = RestaurantListSearch()
        self.navigationController?.pushViewController(restaurantListSearch, animated: true)
    }
    
    //관심 목록 저장
    func interestRestaurantDidAdd(_ notification: Notification ) {
        
        guard let interestRestaurant = notification.userInfo?["interestRestaurant"] as? [InterestRestaurant] else { return }
        
        var count = 0
        while(count < interestRestaurant.count) {
            self.interestRestaurant.append(interestRestaurant[count])
            count = count + 1
        }
        self.tableView.reloadData()
    }

    
}


extension InterestRestaurantList: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.interestRestaurant.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "interestRestaurantListCell", for: indexPath) as! InterestRestaurantListCell
        cell.configure(interestRestaurant: self.interestRestaurant[indexPath.item])
        return cell
    }
}

extension InterestRestaurantList: UITableViewDelegate {
    //선택
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("\(indexPath)가 선택!")
        AppDelegate.instance?.MealListScreen(id : self.interestRestaurant[indexPath.row]._id, name: self.interestRestaurant[indexPath.row].companyName)
    }
    
    //삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        self.interestRestaurant.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        //TODO :: 저장 필요
    }
    
    //위치 이동
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var interestRestaurant = self.interestRestaurant
        let removeTaks = interestRestaurant.remove(at: sourceIndexPath.row)
        interestRestaurant.insert(removeTaks, at: destinationIndexPath.row)
        self.interestRestaurant = interestRestaurant
        //TODO :: 저장 필요 한가??
    }
    
    
    //cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FixedCommonSet.tableViewCellHeight
    }
}


