//
//  BusinessUsersMealList.swift
//  JJam
//
//  Created by admin on 2017. 7. 18..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

final class BusinessUsersMealList: UIViewController {
    //MARK: Properties
    fileprivate let restaurant_Id: String
    fileprivate var didSetupConstraints = false
    fileprivate var segmentedIndexAndCode = 0
    fileprivate var meal: [Meal] = []
    fileprivate var restaurantCertification:String!
    var managerNotice:String!
   
    //MARK: Constants
    fileprivate struct Metric {
        static let textViewMid = CGFloat(10)
        static let textViewHeight = CGFloat(70)

        static let segmentedMid = CGFloat(20)
        static let segmentedHeight = CGFloat(45)
        
        static let labelMid = CGFloat(10)
        static let labelHeight = CGFloat(20)
        
        static let commonOffset = CGFloat(7)
        static let commonHeight = CGFloat(40)
    }
    
    //MARK: UI
    fileprivate let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    fileprivate let segmentedControl = UISegmentedControl()
    fileprivate let segmentedTitles: Array<String> = ["오늘 식단","계획 식단","지난 식단","사진 식단"]
    fileprivate let label = UILabel()
    fileprivate let textView = UITextView()
    fileprivate let tableView = UITableView(frame: .zero, style: .plain)
    
    //NotificationCenter에 등록된 옵저버의 타겟 객체가 소멸
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: init
    init(restaurant_Id: String) {
        self.restaurant_Id = restaurant_Id
        super.init(nibName: nil, bundle: nil)
        setControlTuple(editMode: true, writeMode: false)
        self.title = "식단"
        self.tabBarItem.image = UIImage(named: "tab-restaurant")
        self.tabBarItem.selectedImage = UIImage(named: "tab-restaurant-selected")
        
        self.restaurantCertification = "n"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setControlTuple(editMode: true, writeMode: false)
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
            title: "식단 추가",
            style: .done,
            target: self,
            action: #selector(addButtonDidTap)
        )
        self.navigationItem.rightBarButtonItem?.tintColor = .white

        UICommonSetLoading(self.activityIndicatorView)
        
        //운영자 공지사항 조회
        managerNoticeSearch()
        
        //식당 인증 & 공지 사항(공지 사용안함)
        restaurantInfo()
        
        //segmentedControl
        UICommonSetSegmentedControl(self.segmentedControl, titles: segmentedTitles, font: 0)
        self.segmentedControl.addTarget(self, action: #selector(changeSegmentedControl), for: .valueChanged)
        self.segmentedControl.selectedSegmentIndex = self.segmentedIndexAndCode

        
        //인증
        if (self.restaurantCertification == "y") {
            UICommonSetLabel(self.label, text: "사업자 등록증 인증 상태입니다.", color: 2)
            self.label.textAlignment = .center
        } else {
            UICommonSetLabel(self.label, text: "사업자 등록증 미인증 상태입니다.", color: 1)
            self.label.textAlignment = .center
        }
        self.view.addSubview(self.label)
        
        //공지사항
        self.textView.text = fixedNotice
        UICommonSetTextViewDisable(self.textView)
        
        //식단
        self.tableView.register(MealListCell.self, forCellReuseIdentifier: "mealListCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.view.addSubview(self.segmentedControl)
        self.view.addSubview(self.label)
        self.view.addSubview(self.textView)
        self.view.addSubview(self.tableView)
        //activityIndicatorView는 경우에 따라 안보이는 경우가 있어서 항상 가장 늦게 addSubview 한다.
        self.view.addSubview(self.activityIndicatorView)
        //updateViewConstraints 자동 호출
        self.view.setNeedsUpdateConstraints()
    }
    
    //XIB로 view 를 생성하지 않고 view을 로드할때 사용된다
    override func loadView() {
        super.loadView()
        //NotificationCenter에 등록
        NotificationCenter.default.addObserver(self, selector: #selector(businessUsersMealListDidAdd), name: .businessUsersMealListDidAdd, object: nil)
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
            self.segmentedControl.snp.makeConstraints { make in
                make.left.equalTo(Metric.segmentedMid)
                make.right.equalTo(-Metric.segmentedMid)
                make.top.equalTo(self.textView.snp.bottom).offset(Metric.commonOffset)
                make.height.equalTo(Metric.segmentedHeight)
            }
            self.label.snp.makeConstraints { make in
                make.left.equalTo(Metric.labelMid)
                make.right.equalTo(-Metric.labelMid)
                make.top.equalTo(self.segmentedControl.snp.bottom).offset(Metric.commonOffset)
                make.height.equalTo(Metric.labelHeight)
            }
            self.tableView.snp.makeConstraints { make in
                make.top.equalTo(self.label.snp.bottom).offset(Metric.commonOffset)
                make.left.right.equalToSuperview()
                make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
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
        if self.segmentedIndexAndCode == 2 {
            let alertController = UIAlertController(
                title: self.title,
                message: segmentedTitles[self.segmentedIndexAndCode]  + "은 삭제가 불가능 합니다.",
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
            guard !self.meal.isEmpty else { return }
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(
                title: "완료",
                style: .done,
                target: self,
                action: #selector(doneButtonDidTap)
            )
            self.navigationItem.leftBarButtonItem?.tintColor = .white
            self.tableView.setEditing(true, animated: true)
        }
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
    
    //신규 식단 추가
    func addButtonDidTap() {
        //UI 버그 처리
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "식단 추가",
            style: .done,
            target: self,
            action: #selector(addButtonDidTap)
        )
        self.navigationItem.rightBarButtonItem?.tintColor = .white

        let newMeal = [Meal](JSONArray: [["meal_Id": "",
                                          "restaurant_Id": restaurant_Id,     //필수
                                          "mealDate": "",
                                          "location": "",
                                          "division": "",
                                          "stapleFood1": "",
                                          "soup1": "",
                                          "sideDish1": "",
                                          "sideDish2": "",
                                          "sideDish3": "",
                                          "sideDish4": "",
                                          "sideDish5": "",
                                          "sideDish6": "",
                                          "sideDish7": "",
                                          "dessert1": "",
                                          "dessert2": "",
                                          "dessert3": "",
                                          "remarks": "",            //필수
                                          "foodImage": ""]])        //필수
        setControlTuple(editMode: true, writeMode: true)
        let mealDetail = MealDetail(viewMeal: newMeal)
        self.navigationController?.pushViewController(mealDetail, animated: true)
    }

    //MARK: ACTION
    //운영자 공지사항 조회
    func managerNoticeSearch() {
        UICommonSetLoadingService(self.activityIndicatorView, service: true)
        CommonNetWorking.managerNoticeSearch(division: "1") { [weak self] response in
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
    
    //식당 인증 & 공지 : 중 인증만 사용
    func restaurantInfo() {
        UICommonSetLoadingService(self.activityIndicatorView, service: true)
        CommonNetWorking.restaurantInfo(restaurant_Id: self.restaurant_Id) { [weak self] response in
            guard let `self` = self else { return }
            if response.count > 0 {
                UICommonSetLoadingService(self.activityIndicatorView, service: false)
                //인증
                let message = response[0].message
                if message != nil {
                    self.label.text = message
                    self.label.textColor = .red
                    
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
                    //인증
                    self.restaurantCertification = response[0].certification
                    if (self.restaurantCertification == "y") {
                        UICommonSetLabel(self.label, text: "사업자 등록증 인증 상태입니다.", color: 2)
                    } else {
                        UICommonSetLabel(self.label, text: "사업자 등록증 미인증 상태입니다.", color: 1)
                    }
                    //식단 조회
                    self.mealSearch()
                }
            }
        }
    }
    
    //식단 조회
    func mealSearch() {
        UICommonSetLoadingService(self.activityIndicatorView, service: true)
        CommonNetWorking.mealSearch(restaurant_Id: self.restaurant_Id, segmentedIndexAndCode: self.segmentedIndexAndCode) { [weak self] response in
            guard let `self` = self else { return }
            if response.count > 0 {
                let message = response[0].message
                if message != nil {
                    let delayInSeconds = SuperConstants.msgDelayInSeconds
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                        UICommonSetLoadingService(self.activityIndicatorView, service: false)
                    }
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
                    return
                }
            }
            self.meal = response
            self.tableView.reloadData()         //식단이 없을때 빠른 클릭시 오류 발생 방지용
            //tableView 이미지 다운로딩 까지 기달려주기
            let delayInSeconds = SuperConstants.tableViewReloadDelayInSeconds
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                self.tableView.reloadData()     //최종 적으로 보여주기
                UICommonSetLoadingService(self.activityIndicatorView, service: false)
            }
        }
    }
    
    //세그먼트 메뉴 클릭
    func changeSegmentedControl() {
        self.segmentedIndexAndCode = segmentedControl.selectedSegmentIndex
        self.doneButtonDidTap()
        mealSearch()
    }
    
    //Notification 관심 목록 저장
    func businessUsersMealListDidAdd(_ notification: Notification ) {
        setControlTuple(editMode: true, writeMode: false)
        mealSearch()
    }
   
    //식단 삭제
    func tableViewMealDel(meal_Id: String, index: Int) {
        UICommonSetLoadingService(self.activityIndicatorView, service: true)
        BusinessUsersNetWorking.mealDel(meal_Id: meal_Id) { [weak self] response in
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
                            if message == "식단 삭제가 완료되었습니다." {
                                self.doneButtonDidTap()
                                self.mealSearch()
                            }
                    }
                    alertController.addAction(alertConfirm)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
            }
        }
    }
    
    /*
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
     // Dispose of any resources that can be recreated.
    }
    */
    
}


extension BusinessUsersMealList: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.meal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //MealListCell 공통으로 사용
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealListCell", for: indexPath) as! MealListCell
        cell.configure(meal: self.meal[indexPath.item], segmentedIndexAndCode: self.segmentedIndexAndCode)
        return cell
    }
}

extension BusinessUsersMealList: UITableViewDelegate {
    //선택
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("\(indexPath)가 선택!")
        //지난 식단 수정 불가
        if self.segmentedIndexAndCode == 2 {
            setControlTuple(editMode: false, writeMode: false)
        } else {
            setControlTuple(editMode: true, writeMode: false)
        }
        let meal = MealDetail(viewMeal: [self.meal[indexPath.row]])
        self.navigationController?.pushViewController(meal, animated: true)
    }
    
    //삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //print(self.meal[indexPath.row].meal_Id)
        
        let message = self.meal[indexPath.row].mealDate + " (" + self.meal[indexPath.row].mealDateLabel + ") " +
            self.meal[indexPath.row].division + "\n" +
            "위치 : " + self.meal[indexPath.row].location + "\n" +
            "식단을 삭제 하시겠습니까?"
        
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
                self.tableViewMealDel(meal_Id:self.meal[indexPath.row].meal_Id, index: indexPath.row)
        }
        alertController.addAction(alertCancel)
        alertController.addAction(alertConfirm)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SuperConstants.tableViewCellHeight70
    }
    
}

