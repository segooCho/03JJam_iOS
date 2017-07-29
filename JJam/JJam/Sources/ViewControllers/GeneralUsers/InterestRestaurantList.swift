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
    fileprivate let JJamUserDefaultsKey = "JJamUserDefaultsKey"
    fileprivate var didSetupConstraints = false
    fileprivate var interestRestaurant: [InterestRestaurant] = []
    fileprivate let fixedNotice = "www.JJam.com 에서 가맹점 검색 및 가맹점 요청이 가능합니다."
    
    //MARK: Constants
    fileprivate struct Metric {
        static let textViewMid = CGFloat(10)
        static let textViewHeight = CGFloat(70)
        
        static let commonOffset = CGFloat(7)
    }

    //MARK: UI
    fileprivate let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
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
        
        //로컬 저장 정보 불러오기
        if let dicts = UserDefaults.standard.array(forKey: JJamUserDefaultsKey) as? [[String: Any]] {
            self.interestRestaurant = dicts.flatMap { (disc: [String: Any]) -> InterestRestaurant? in
                if let _id = disc["_id"] as? String, let companyName = disc["companyName"] as? String {
                    return InterestRestaurant(_id: _id, companyName: companyName)
                } else {
                    return nil
                }
            }
        }
        //데이터 임시 처리
        //self.interestRestaurant.append(InterestRestaurant(_id: "1", companyName: "한라시그마 구내식당"))
        //self.interestRestaurant.append(InterestRestaurant(_id: "2", companyName: "벽산 구내식당"))
        //self.interestRestaurant.append(InterestRestaurant(_id: "3", companyName: "조은 함바"))
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

        //관심 식당
        self.tableView.register(InterestRestaurantListCell.self, forCellReuseIdentifier: "interestRestaurantListCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.view.addSubview(self.textView)
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.activityIndicatorView)
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
            self.activityIndicatorView.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            self.textView.snp.makeConstraints { make in
                make.left.equalTo(Metric.textViewMid)
                make.right.equalTo(-Metric.textViewMid)
                make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(Metric.commonOffset)
                make.height.equalTo(Metric.textViewHeight)
            }
            self.tableView.snp.makeConstraints { make in
                make.top.equalTo(self.textView.snp.bottom).offset(Metric.commonOffset)
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
        let restaurantListSearch = RestaurantListSearch()
        self.navigationController?.pushViewController(restaurantListSearch, animated: true)
    }
    
    //Notification 관심 목록 저장
    func interestRestaurantDidAdd(_ notification: Notification ) {
        guard let interestRestaurant = notification.userInfo?["interestRestaurant"] as? [InterestRestaurant] else { return }
        
        UICommonSetLoading(self.activityIndicatorView, service: true)
        //중복 제거 처리 및 등록
        for notificationData in interestRestaurant {
            if self.interestRestaurant.count == 0 {
                self.interestRestaurant.append(notificationData)
            } else {
                var checkDeduplication = true
                for data in self.interestRestaurant {
                    if (data._id == notificationData._id) {
                        checkDeduplication = false
                    }
                }
                if checkDeduplication == true {
                    self.interestRestaurant.append(notificationData)
                }
            }
        }
        self.tableView.reloadData()
        UICommonSetLoading(self.activityIndicatorView, service: false)
        UserDefaultsSet()
    }
    
    //로컬 파일로 저장
    func UserDefaultsSet() {
        let dicts:[[String: Any]] = self.interestRestaurant.map {
            (interestRestaurant: InterestRestaurant) -> [String: Any] in
            return [
                "_id": interestRestaurant._id,
                "companyName": interestRestaurant.companyName,
                ]
        }
        UserDefaults.standard.set(dicts, forKey: JJamUserDefaultsKey)
        //로컬 파일로 저장
        UserDefaults.standard.synchronize()
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
        let mealList = MealList(interestRestaurantId : self.interestRestaurant[indexPath.row]._id, interestRestaurantName: self.interestRestaurant[indexPath.row].companyName)
        self.navigationController?.pushViewController(mealList, animated: true)
    }
    
    //삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        self.interestRestaurant.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        UserDefaultsSet()
    }
    
    //위치 이동
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var interestRestaurant = self.interestRestaurant
        let removeInterestRestaurant = interestRestaurant.remove(at: sourceIndexPath.row)
        interestRestaurant.insert(removeInterestRestaurant, at: destinationIndexPath.row)
        self.interestRestaurant = interestRestaurant
        UserDefaultsSet()
    }
    //cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FixedCommonSet.tableViewCellHeight
    }
}


