//
//  BusinessUsersMealDetail.swift
//  JJam
//
//  Created by admin on 2017. 7. 19..
//  Copyright © 2017년 admin. All rights reserved.
//


import UIKit

final class BusinessUsersMealDetail: UIViewController {
    //MARK: Properties
    var didSetupConstraints = false
    var businessUsersDetail: [BusinessUsersDetail] = [] /*{
     didSet {
     self.saveAll()
     }
     }
     */
    fileprivate let businessUsersMealDetailId:String!
    
    //MARK: UI
    //fileprivate let detailTableView = UITableView(frame: .zero, style: .grouped)
    fileprivate let detailTableView = UITableView(frame: .zero, style: .plain)
    //fileprivate let progressView = UIProgressView()
    
    //MARK: init
    init(businessUsersMealDetailId: String) {
        self.businessUsersMealDetailId = businessUsersMealDetailId
        super.init(nibName: nil, bundle: nil)
        //데이터 임시 처리
        if (businessUsersMealDetailId != ""){
            self.businessUsersDetail.append(BusinessUsersDetail(id: "1", imageString: "01.jpg", dateString: "2017-07-11일 (화)", division: "아침",
                                  stapleFood: "현미밥", soup: "된장국", sideDish1: "김치", sideDish2: "돈까스", sideDish3: "햄",
                                  sideDish4: "김", dessert: "국수, 김치볶음밥", remarks: "오늘도 정성을 다해 준비하였습니다.\n한라시그마 구내식당\n\n\n\n\n감사합니다."))
        } else {
            self.businessUsersDetail.append(BusinessUsersDetail(id: "", imageString: "", dateString: "", division: "",
                                    stapleFood: "", soup: "", sideDish1: "", sideDish2: "", sideDish3: "",
                                    sideDish4: "", dessert: "", remarks: ""))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.title = "상세 식단"
        
        //cancelButton
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelButtonDidTap)
        )
        
        //상세식단
        self.detailTableView.register(BusinessUsersMealDetailImageCell.self, forCellReuseIdentifier: "businessUsersMealDetailImageCell")
        self.detailTableView.register(BusinessUsersMealDetailTextCell.self, forCellReuseIdentifier: "businessUsersMealDetailTextCell")
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //view가 안보이다가 다시 보이게 되었을때 발생하는 이벤트
    //TabBar 이동 후 재 선택 시
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true) // No need for semicolon
        if self.didSetupConstraints {
            //NavigationController popViewController
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK: ACTION
    func cancelButtonDidTap() {
        //NavigationController popViewController
        _ = self.navigationController?.popViewController(animated: true)
    }
}


extension BusinessUsersMealDetail: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "businessUsersMealDetailImageCell", for: indexPath) as! BusinessUsersMealDetailImageCell
            cell.configure(businessUsersMealDetailImageString: self.businessUsersDetail[0].imageString)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "businessUsersMealDetailTextCell", for: indexPath) as! BusinessUsersMealDetailTextCell
            cell.configure(businessUsersDetail: self.businessUsersDetail[0])
            return cell
        }
    }
}

extension BusinessUsersMealDetail: UITableViewDelegate {
    //cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return MealDetailImageCell.height(width: tableView.frame.width)
        } else {
            return MealDetailTextCell.height()
        }
    }
}
