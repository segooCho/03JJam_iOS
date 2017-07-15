//
//  MealList.swift
//  JJam
//
//  Created by admin on 2017. 7. 15..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

final class MealList: UIViewController {
    //MARK : Properties
    var meal: [Meal] = [] /*{
     didSet {
     self.saveAll()
     }
     }
     */
    
    var InterestRestaurantId:String!
    var InterestRestaurantName:String!
    var InterestRestaurantNotice:String!

    //MARK: UI
    fileprivate let tableView = UITableView(frame: .zero, style: .plain)
    fileprivate let textView = UITextView()

    //MARK: init
    init() {
        super.init(nibName: nil, bundle: nil)
        //데이터 임시 처리
        self.meal.append(Meal(id: "1", imageString: "01.jpg", dateString: "2017-07-11일(화) 아침", remarks: "등록 내용 없음"))
        self.meal.append(Meal(id: "2", imageString: "02.jpg", dateString: "2017-07-11일(화) 점심", remarks: "현미밥, 된장국, 김치, 돈까스, 김, 불고기"))
        self.meal.append(Meal(id: "3", imageString: "03.jpg", dateString: "2017-07-11일(화) 저녁", remarks: "등록 내용 없음"))
        self.meal.append(Meal(id: "4", imageString: "04.jpg", dateString: "2017-07-10일(월) 아침", remarks: "등록 내용 없음"))
        self.meal.append(Meal(id: "5", imageString: "05.jpg", dateString: "2017-07-10일(월) 점심", remarks: "현미밥, 된장국, 김치, 돈까스, 김, 불고기"))
        self.meal.append(Meal(id: "6", imageString: "06.jpg", dateString: "2017-07-10일(월) 저녁", remarks: "등록 내용 없음"))
        self.meal.append(Meal(id: "7", imageString: "07.jpg", dateString: "2017-07-07일(금) 아침", remarks: "등록 내용 없음"))
        self.meal.append(Meal(id: "8", imageString: "08.jpg", dateString: "2017-07-07일(금) 점심", remarks: "현미밥, 된장국, 김치, 돈까스, 김, 불고기"))
        self.meal.append(Meal(id: "9", imageString: "09.jpg", dateString: "2017-07-07일(금) 저녁", remarks: "등록 내용 없음"))
        
        
        self.InterestRestaurantNotice = "공지사항\n안녕하세요. 한라시그마 구내식당 입니다.\n*월요일 ~ 금요일 까지 영업합니다.\n*토요일, 일요일, 공휴일은 휴무입니다.\n감사합니다."
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK : View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = InterestRestaurantName
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelButtonDidTap)
        )
        
        //공지사항
        self.textView.text = self.InterestRestaurantNotice
        let color = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0).cgColor
        self.textView.layer.borderColor = color
        self.textView.layer.borderWidth = 0.5
        self.textView.layer.cornerRadius = 5
        self.textView.font = UIFont.systemFont(ofSize: 14)
        self.textView.isEditable = false
        //TODO :: scroll 포지션 시작점이 문제가 있음
        self.textView.scrollRangeToVisible(NSMakeRange(-10, 0))
        self.view.addSubview(self.textView)
        
        self.textView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(10)
            make.height.equalTo(100)
        }
        
        //식단
        self.tableView.register(MealListCell.self, forCellReuseIdentifier: "mealListCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(self.tableView)
        
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.textView.snp.bottom).offset(5)
            make.left.right.height.equalToSuperview()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableView.layer.frame = (self.tableView.layer.frame).insetBy(dx: 0, dy: 0)
        self.tableView.layer.borderColor = UIColor.gray.cgColor
        self.tableView.layer.cornerRadius = (self.tableView.frame.height)/2
        self.tableView.layer.masksToBounds = false
        self.tableView.clipsToBounds = true
        self.tableView.layer.borderWidth = 0.5
        self.tableView.contentMode = UIViewContentMode.scaleAspectFill
    }
    
    //MARK : ACTION
    func cancelButtonDidTap() {
        AppDelegate.instance?.InterestRestaurantListScreen()
    }
    
    // MARK: Actions
    func textFieldDidChangeText(_ textField: UITextField) {
        textField.textColor = .black
    }
    
}
