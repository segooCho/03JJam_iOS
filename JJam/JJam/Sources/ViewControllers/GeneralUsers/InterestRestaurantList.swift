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
    fileprivate var didSetupConstraints = false
    fileprivate var interestRestaurant: [InterestRestaurant] = []
    
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
        if let dicts = UserDefaults.standard.array(forKey: JJamUserDefaultsKeyInterestRestaurantList) as? [[String: Any]] {
            self.interestRestaurant = dicts.flatMap { (disc: [String: Any]) -> InterestRestaurant? in
                if let restaurant_Id = disc["restaurant_Id"] as? String, let companyName = disc["companyName"] as? String {
                    return InterestRestaurant(restaurant_Id: restaurant_Id, companyName: companyName)
                } else {
                    return nil
                }
            }
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
        
        UICommonSetLoading(self.activityIndicatorView)
        
        //공지사항
        self.textView.text = fixedNotice
        UICommonSetTextViewDisable(self.textView)

        //운영자 공지사항 조회
        //managerNoticeSearch();

        //관심 식당
        self.tableView.register(InterestRestaurantListCell.self, forCellReuseIdentifier: "interestRestaurantListCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.view.addSubview(self.textView)
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.activityIndicatorView)
        //updateViewConstraints 자동 호출
        self.view.setNeedsUpdateConstraints()
        
        //초기 실행시 저장 목록 확인
        UserDefaultsSet()
    }
    
    //MARK: View Life Cycle (화면이 다시 보이면)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //운영자 공지사항 조회
        managerNoticeSearch();
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
    
    //운영자 공지사항 조회
    func managerNoticeSearch() {
        UICommonSetLoadingService(self.activityIndicatorView, service: true)
        CommonNetWorking.managerNoticeSearch(division: "0") { [weak self] response in
            guard let `self` = self else { return }
            if response.count > 0 {
                UICommonSetLoadingService(self.activityIndicatorView, service: false)
                //운영자 공지사항
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
                            return
                    }
                    alertController.addAction(alertConfirm)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    self.textView.text = response[0].text
                }
            }
        }
    }
    
    //Notification 관심 목록 저장
    func interestRestaurantDidAdd(_ notification: Notification ) {
        guard let interestRestaurant = notification.userInfo?["interestRestaurant"] as? [InterestRestaurant] else { return }
        UICommonSetLoadingService(self.activityIndicatorView, service: true)
        //중복 제거 처리 및 등록
        for notificationData in interestRestaurant {
            if self.interestRestaurant.count == 0 {
                self.interestRestaurant.append(notificationData)
            } else {
                var checkDeduplication = true
                for data in self.interestRestaurant {
                    if (data.restaurant_Id == notificationData.restaurant_Id) {
                        checkDeduplication = false
                    }
                }
                if checkDeduplication == true {
                    self.interestRestaurant.append(notificationData)
                }
            }
        }
        self.tableView.reloadData()
        UICommonSetLoadingService(self.activityIndicatorView, service: false)
        UserDefaultsSet()
    }
    
    //로컬 파일로 저장
    func UserDefaultsSet() {
        let dicts:[[String: Any]] = self.interestRestaurant.map {
            (interestRestaurant: InterestRestaurant) -> [String: Any] in
            return [
                "restaurant_Id": interestRestaurant.restaurant_Id,
                "companyName": interestRestaurant.companyName,
                ]
        }
        UserDefaults.standard.set(dicts, forKey: JJamUserDefaultsKeyInterestRestaurantList)
        //로컬 파일로 저장
        UserDefaults.standard.synchronize()
        
        if (dicts.count == 0) {
            //버튼 변경
            self.doneButtonDidTap();
            let alertController = UIAlertController(
                title: self.title,
                message: "즐겨찾기 식당 목록이 없습니다.\n즐겨찾기 식당을 검색하시겠습니까?",
                preferredStyle: .alert
            )
            let alertCancel = UIAlertAction(
                title: "취소",
                style: .default) { _ in
                    // 확인 후 작업
                    return
            }
            let alertConfirm = UIAlertAction(
                title: "확인",
                style: .default) { _ in
                    // 확인 후 작업
                    self.addButtonDidTap();
                    return
            }
            alertController.addAction(alertCancel)
            alertController.addAction(alertConfirm)
            self.present(alertController, animated: true, completion: nil)
        }
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
        let mealList = MealList(interestRestaurantId : self.interestRestaurant[indexPath.row].restaurant_Id, interestRestaurantName: self.interestRestaurant[indexPath.row].companyName)
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
        return SuperConstants.tableViewCellHeight
    }
}


