//
//  MealDetail.swift
//  JJam
//
//  Created by admin on 2017. 7. 17..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

final class MealDetail: UIViewController {
    //MARK: Properties
    var didSetupConstraints = false
    var detail: [Detail] = [] /*{
     didSet {
     self.saveAll()
     }
     }
     */
    fileprivate let mealDetailId:String!
    
    //MARK: UI
    //fileprivate let detailTableView = UITableView(frame: .zero, style: .grouped)
    fileprivate let detailTableView = UITableView(frame: .zero, style: .plain)
    //fileprivate let progressView = UIProgressView()

    //MARK: init
    init(mealDetailId: String) {
        self.mealDetailId = mealDetailId
        super.init(nibName: nil, bundle: nil)
        //데이터 임시 처리
        self.detail.append(Detail(id: "1", imageString: "01.jpg", dateString: "2017-07-11일 (화)", division: "아침",
                                  stapleFood: "현미밥", soup: "된장국", sideDish1: "김치", sideDish2: "돈까스", sideDish3: "햄",
                                  sideDish4: "김", dessert: "국수, 김치볶음밥", remarks: "오늘도 정성을 다해 준비하였습니다.\n한라시그마 구내식당\n\n\n\n\n감사합니다."))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: View Life Cycle
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
        //updateViewConstraints 자동 호출
        self.view.setNeedsUpdateConstraints()
    }
    
    //MARK: 애플 추천 방식으로 한번만 화면을 그리도록 한다.
    //setNeedsUpdateConstraints() 필요
    override func updateViewConstraints() {
        if !self.didSetupConstraints {
            self.didSetupConstraints = true
            self.detailTableView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        super.updateViewConstraints()
    }
    
    //MARK: ACTION
    func cancelButtonDidTap() {
        //NavigationController popViewController
        //self.navigationController?.popViewController(animated: true)
        _ = self.navigationController?.popViewController(animated: true)
    }
}
