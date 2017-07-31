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
    fileprivate let _id: String
    fileprivate var didSetupConstraints = false
    fileprivate var segmentedIndexAndCode = 0
    fileprivate var meal: [Meal] = []
    var restaurantCertification:String!

    //MARK: Constants
    fileprivate struct Metric {
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
    fileprivate let tableView = UITableView(frame: .zero, style: .plain)
    
    //MARK: init
    init(_id: String) {
        self._id = _id
        super.init(nibName: nil, bundle: nil)
        
        self.title = "식단"
        self.tabBarItem.image = UIImage(named: "tab-restaurant")
        self.tabBarItem.selectedImage = UIImage(named: "tab-restaurant-selected")
        
        self.restaurantCertification = "n"

        //식당 인증 & 공지 사항
        restaurantInfo()
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

        //segmentedControl
        UICommonSetSegmentedControl(self.segmentedControl, titles: segmentedTitles)
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
        
        //식단
        self.tableView.register(MealListCell.self, forCellReuseIdentifier: "mealListCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.view.addSubview(self.segmentedControl)
        self.view.addSubview(self.label)
        self.view.addSubview(self.tableView)
        //activityIndicatorView는 경우에 따라 안보이는 경우가 있어서 항상 가장 늦게 addSubview 한다.
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
            self.segmentedControl.snp.makeConstraints { make in
                make.left.equalTo(Metric.segmentedMid)
                make.right.equalTo(-Metric.segmentedMid)
                make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(Metric.commonOffset)
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
                barButtonSystemItem: .done,
                target: self,
                action: #selector(doneButtonDidTap)
            )
            self.tableView.setEditing(true, animated: true)
        }
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
        let businessUsersMealDetail = BusinessUsersMealDetail(businessUsersMealDetailId: "")
        self.navigationController?.pushViewController(businessUsersMealDetail, animated: true)
    }

    //MARK: ACTION
    //식당 인증
    func restaurantInfo() {
        UICommonSetLoadingService(self.activityIndicatorView, service: true)
        GeneralUsersNetWorking.restaurantInfo(restaurant_Id: self._id) { [weak self] response in
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
        GeneralUsersNetWorking.mealSearch(restaurant_Id: self._id, segmentedIndexAndCode: self.segmentedIndexAndCode) { [weak self] response in
            guard let `self` = self else { return }
            if response.count > 0 {
                let message = response[0].message
                if message != nil {
                    UICommonSetLoadingService(self.activityIndicatorView, service: false)
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
            //tableView 이미지 다운로딩 까지 기달려주기
            let delayInSeconds = 2.0
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                self.tableView.reloadData()
                UICommonSetLoadingService(self.activityIndicatorView, service: false)
            }
        }
    }
    
    //세그먼트 메뉴 클릭
    func changeSegmentedControl() {
        self.segmentedIndexAndCode = segmentedControl.selectedSegmentIndex
        mealSearch()
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
        //MealListCell 공통으로 사용?????
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealListCell", for: indexPath) as! MealListCell
        cell.configure(meal: self.meal[indexPath.item], segmentedIndexAndCode: self.segmentedIndexAndCode)
        return cell
    }
}

extension BusinessUsersMealList: UITableViewDelegate {
    //선택
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("\(indexPath)가 선택!")
        //NavigationController pushViewController
        //TODO :: 디테일 수정 처리
        let businessUsersMealDetail = BusinessUsersMealDetail(businessUsersMealDetailId: self.meal[indexPath.row]._id)
        self.navigationController?.pushViewController(businessUsersMealDetail, animated: true)
    }
    
    //cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FixedCommonSet.tableViewCellHeight70
    }
    
}

