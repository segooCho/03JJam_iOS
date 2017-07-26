//
//  MealList.swift
//  JJam
//
//  Created by admin on 2017. 7. 15..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

final class MealList: UIViewController {
    //MARK: Properties
    fileprivate var didSetupConstraints = false
    fileprivate var segmentedIndexAndCode = 0
    fileprivate var meal: [Meal] = []
    
    fileprivate let interestRestaurantId:String!
    fileprivate let interestRestaurantName:String!
    var interestRestaurantCertification:String!
    var interestRestaurantNotice:String!

    //MARK: UI
    fileprivate let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    fileprivate let segmentedControl = UISegmentedControl()
    fileprivate let segmentedTitles: Array<String> = ["오늘 식단","계획 식단","지난 식단"]
    fileprivate let label = UILabel()
    fileprivate let textView = UITextView()
    fileprivate let tableView = UITableView(frame: .zero, style: .plain)

    //MARK: init
    init(interestRestaurantId: String, interestRestaurantName: String) {
        self.interestRestaurantId = interestRestaurantId
        self.interestRestaurantName = interestRestaurantName
        super.init(nibName: nil, bundle: nil)
        
        self.interestRestaurantCertification = "n"
        self.interestRestaurantNotice = ""
        
        //식당 인증
        restaurantCertification()
        //식당 공지 사항
        restaurantNotice()
        //식단 조회
        mealSearch()
        //데이터 임시 처리
        //self.interestRestaurantCertification = "n"
        //self.interestRestaurantNotice = "공지사항\n안녕하세요. 한라시그마 구내식당 입니다.\n*월요일 ~ 금요일 까지 영업합니다.\n*토요일, 일요일, 공휴일은 휴무입니다.\n\n\n\n감사합니다."
        /*
        self.meal.append(Meal(id: "1", imageString: "01.jpg", dateString: "2017-07-11일(화) 아침", summary: "등록 내용 없음"))
        self.meal.append(Meal(id: "2", imageString: "02.jpg", dateString: "2017-07-11일(화) 점심", summary: "현미밥, 된장국, 김치, 돈까스, 김, 불고기"))
        self.meal.append(Meal(id: "3", imageString: "03.jpg", dateString: "2017-07-11일(화) 저녁", summary: "등록 내용 없음"))
        self.meal.append(Meal(id: "4", imageString: "04.jpg", dateString: "2017-07-10일(월) 아침", summary: "등록 내용 없음"))
        self.meal.append(Meal(id: "5", imageString: "05.jpg", dateString: "2017-07-10일(월) 점심", summary: "현미밥, 된장국, 김치, 돈까스, 김, 불고기"))
        self.meal.append(Meal(id: "6", imageString: "06.jpg", dateString: "2017-07-10일(월) 저녁", summary: "등록 내용 없음"))
        self.meal.append(Meal(id: "7", imageString: "07.jpg", dateString: "2017-07-07일(금) 아침", summary: "등록 내용 없음"))
        self.meal.append(Meal(id: "8", imageString: "08.jpg", dateString: "2017-07-07일(금) 점심", summary: "현미밥, 된장국, 김치, 돈까스, 김, 불고기"))
        self.meal.append(Meal(id: "9", imageString: "09.jpg", dateString: "2017-07-07일(금) 저녁", summary: "등록 내용 없음"))
        */
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.interestRestaurantName
        self.view.backgroundColor = .white
        
        //scroll의 내부 여백 발생시 사용()
        self.automaticallyAdjustsScrollViewInsets = false

        //cancelButton
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelButtonDidTap)
        )
        
        //segmentedControl
        UICommonSetSegmentedControl(self.segmentedControl, titles: segmentedTitles)
        self.segmentedControl.addTarget(self, action: #selector(changeSegmentedControl), for: .valueChanged)
        self.segmentedControl.selectedSegmentIndex = self.segmentedIndexAndCode
        
        //인증 : viewDidLoad 시점에 값을 받지 못함
        if (self.interestRestaurantCertification == "y") {
            UICommonSetLabel(self.label, text: "사업자 등록증 인증 업체입니다.")
            self.label.textColor = .blue
            self.label.textAlignment = .center
        } else {
            UICommonSetLabel(self.label, text: "사업자 등록증 미인증 업체입니다.")
            self.label.textColor = .red
            self.label.textAlignment = .center
        }

        //공지사항 : viewDidLoad 시점에 값을 받지 못함
        self.textView.text = self.interestRestaurantNotice
        UICommonSetTextViewDisable(self.textView)
        
        //식단
        self.tableView.register(MealListCell.self, forCellReuseIdentifier: "mealListCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self

        self.view.addSubview(self.segmentedControl)
        self.view.addSubview(self.label)
        self.view.addSubview(self.textView)
        self.view.addSubview(self.tableView)
        //updateViewConstraints 자동 호출
        self.view.setNeedsUpdateConstraints()
    }
    
    //MARK: 애플 추천 방식으로 한번만 화면을 그리도록 한다.
    //setNeedsUpdateConstraints() 필요
    override func updateViewConstraints() {
        if !self.didSetupConstraints {
            self.didSetupConstraints = true
            self.segmentedControl.snp.makeConstraints { make in
                make.left.equalTo(40)
                make.right.equalTo(-40)
                make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(5)
                make.height.equalTo(30)
            }
            self.label.snp.makeConstraints { make in
                make.left.equalTo(10)
                make.right.equalTo(-10)
                make.top.equalTo(self.segmentedControl.snp.bottom).offset(8)
                make.height.equalTo(10)
            }
            self.textView.snp.makeConstraints { make in
                make.left.equalTo(10)
                make.right.equalTo(-10)
                make.top.equalTo(self.label.snp.bottom).offset(5)
                make.height.equalTo(100)
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
    //식당 인증
    func restaurantCertification() {
        self.activityIndicatorView.startAnimating()
        GeneralUsersNetWorking.restaurantCertification(restaurant_Id: self.interestRestaurantId) { [weak self] response in
            guard let `self` = self else { return }
            if response.count > 0 {
                self.interestRestaurantCertification = response[0].certification
                //인증
                if (self.interestRestaurantCertification == "y") {
                    self.label.text = "사업자 등록증 인증 업체입니다."
                    self.label.textColor = .blue
                } else {
                    self.label.text = "사업자 등록증 미인증 업체입니다."
                    self.label.textColor = .red
                }
            }
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    //식당 공지사항
    func restaurantNotice() {
        self.activityIndicatorView.startAnimating()
        GeneralUsersNetWorking.restaurantNotice(restaurant_Id: self.interestRestaurantId) { [weak self] response in
            guard let `self` = self else { return }
            if response.count > 0 {
                self.interestRestaurantNotice = response[0].notice
                //공지사항 : \\n 처리
                let data = self.interestRestaurantNotice.replacingOccurrences(of: "\\n", with: "\n")
                self.textView.text = data
            }
            self.activityIndicatorView.stopAnimating()
        }
    }

    //식단 조회
    func mealSearch() {
        self.activityIndicatorView.startAnimating()
        GeneralUsersNetWorking.mealSearch(restaurant_Id: self.interestRestaurantId, segmentedIndexAndCode: self.segmentedIndexAndCode) { [weak self] response in
            guard let `self` = self else { return }
            self.meal = response
            self.activityIndicatorView.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    //세그먼트 메뉴 클릭
    func changeSegmentedControl() {
        self.segmentedIndexAndCode = segmentedControl.selectedSegmentIndex
        mealSearch()
    }
    
    func cancelButtonDidTap() {
        //AppDelegate.instance?.GeneralUsersTabBarScreen(selectIndex: 0)
        _ = self.navigationController?.popViewController(animated: true)
    }
 
    /*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    */
}


extension MealList: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.meal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealListCell", for: indexPath) as! MealListCell
        cell.configure(meal: self.meal[indexPath.item])
        return cell
    }
}

extension MealList: UITableViewDelegate {
    //선택
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("\(indexPath)가 선택!")
        //NavigationController pushViewController
        let meal = MealDetail(meal: [self.meal[indexPath.row]])
        self.navigationController?.pushViewController(meal, animated: true)
    }
    
    //cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FixedCommonSet.tableViewCellHeight
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealListCell", for: indexPath) as! MealListCell
        cell.imageView?.kf.cancelDownloadTask()
        
        //self.imageView?.setImage(with: meal.foodImage)
        
    }
}
