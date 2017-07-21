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
    var didSetupConstraints = false
    var businessUsersMeal: [BusinessUsersMeal] = [] /*{
     didSet {
     self.saveAll()
     }
     }
     */
    fileprivate let businessUsersRestaurantId:String!
    var businessUsersRestaurantCertification:String!
    
    //MARK: UI
    fileprivate let label = UILabel()
    fileprivate let textView = UITextView()
    fileprivate let tableView = UITableView(frame: .zero, style: .plain)
    
    //MARK: init
    init(businessUsersRestaurantId: String) {
        self.businessUsersRestaurantId = businessUsersRestaurantId
        super.init(nibName: nil, bundle: nil)
        
        self.title = "식단"
        self.tabBarItem.image = UIImage(named: "tab-restaurant")
        self.tabBarItem.selectedImage = UIImage(named: "tab-restaurant-selected")
        
        //데이터 임시 처리
        self.businessUsersRestaurantCertification = "N"
        self.businessUsersMeal.append(BusinessUsersMeal(id: "1", imageString: "01.jpg", dateString: "2017-07-11일(화) 아침", summary: "등록 내용 없음"))
        self.businessUsersMeal.append(BusinessUsersMeal(id: "2", imageString: "02.jpg", dateString: "2017-07-11일(화) 점심", summary: "현미밥, 된장국, 김치, 돈까스, 김, 불고기"))
        self.businessUsersMeal.append(BusinessUsersMeal(id: "3", imageString: "03.jpg", dateString: "2017-07-11일(화) 저녁", summary: "등록 내용 없음"))
        self.businessUsersMeal.append(BusinessUsersMeal(id: "4", imageString: "04.jpg", dateString: "2017-07-10일(월) 아침", summary: "등록 내용 없음"))
        self.businessUsersMeal.append(BusinessUsersMeal(id: "5", imageString: "05.jpg", dateString: "2017-07-10일(월) 점심", summary: "현미밥, 된장국, 김치, 돈까스, 김, 불고기"))
        self.businessUsersMeal.append(BusinessUsersMeal(id: "6", imageString: "06.jpg", dateString: "2017-07-10일(월) 저녁", summary: "등록 내용 없음"))
        self.businessUsersMeal.append(BusinessUsersMeal(id: "7", imageString: "07.jpg", dateString: "2017-07-07일(금) 아침", summary: "등록 내용 없음"))
        self.businessUsersMeal.append(BusinessUsersMeal(id: "8", imageString: "08.jpg", dateString: "2017-07-07일(금) 점심", summary: "현미밥, 된장국, 김치, 돈까스, 김, 불고기"))
        self.businessUsersMeal.append(BusinessUsersMeal(id: "9", imageString: "09.jpg", dateString: "2017-07-07일(금) 저녁", summary: "등록 내용 없음"))
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

        
        //인증
        if (self.businessUsersRestaurantCertification == "Y") {
            UICommonSetLabel(self.label, text: "사업자 등록증 인증 상태입니다.")
            self.label.textColor = .red
            self.label.textAlignment = .center
        } else {
            UICommonSetLabel(self.label, text: "사업자 등록증 미인증 상태입니다.")
            self.label.textColor = .blue
            self.label.textAlignment = .center
        }
        self.view.addSubview(self.label)
        
        //식단
        self.tableView.register(BusinessUsersMealListCell.self, forCellReuseIdentifier: "businessUsersMealListCell")
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
            self.label.snp.makeConstraints { make in
                make.left.equalTo(10)
                make.right.equalTo(-10)
                make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(8)
                make.height.equalTo(10)
            }
            self.tableView.snp.makeConstraints { make in
                make.top.equalTo(self.label.snp.bottom).offset(3)
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
        guard !self.businessUsersMeal.isEmpty else { return }
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
        let businessUsersMealDetail = BusinessUsersMealDetail(businessUsersMealDetailId: "")
        self.navigationController?.pushViewController(businessUsersMealDetail, animated: true)
    }

    
    /*
     override func didReceiveMemoryWarning() {
     super.didReceiveMemoryWarning()
     // Dispose of any resources that can be recreated.
     }
     */
}
