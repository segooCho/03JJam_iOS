//
//  MealDetail.swift
//  JJam
//
//  Created by admin on 2017. 7. 17..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

final class MealDetail: UIViewController {
    //MARK : Properties
    var detail: [Detail] = [] /*{
     didSet {
     self.saveAll()
     }
     }
     */
    fileprivate let mealDetailId:String!
    
    //MARK: UI
    fileprivate let detailTableView = UITableView(frame: .zero, style: .grouped)
    //fileprivate let progressView = UIProgressView()

    //MARK: init
    init(mealDetailId: String) {
        self.mealDetailId = mealDetailId
        super.init(nibName: nil, bundle: nil)
        //데이터 임시 처리
        self.detail.append(Detail(id: "1", imageString: "01.jpg", dateString: "2017-07-11일 (화)", division: "아침",
                                  stapleFood: "현미밥", soup: "된장국", sideDish1: "김치", sideDish2: "돈까스", sideDish3: "햄",
                                  sideDish4: "김", dessert: "국수, 김치볶음밥", remarks: "공지사항\n안녕하세요. 한라시그마 구내식당 입니다.\n*월요일 ~ 금요일 까지 영업합니다.\n*토요일, 일요일, 공휴일은 휴무입니다.\n\n\n\n\n감사합니다."))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK : View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("mealId : \(mealId)")
        self.view.backgroundColor = .white
        self.title = "상세 식단"
        
        //cancelButton
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelButtonDidTap)
        )
        
        //상세식단
        self.detailTableView.register(MealDetailImageCell.self, forCellReuseIdentifier: "mealDetailImageCell")
        self.detailTableView.register(MealDetailTextCell.self, forCellReuseIdentifier: "mealDetailTextCell")
        self.detailTableView.dataSource = self
        self.detailTableView.delegate = self
        self.view.addSubview(self.detailTableView)
        
        self.detailTableView.snp.makeConstraints { make in
            //make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(-50)
            //make.left.right.height.equalToSuperview()
            make.edges.equalToSuperview()
        }
        
    }
    
    //MARK : ACTION
    func cancelButtonDidTap() {
        //NavigationController popViewController
        //self.navigationController?.popViewController(animated: true)
        _ = self.navigationController?.popViewController(animated: true)
    }
}
