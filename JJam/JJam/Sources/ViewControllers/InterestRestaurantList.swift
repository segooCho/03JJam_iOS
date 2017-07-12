//
//  InterestRestaurantList.swift
//  JJam
//
//  Created by admin on 2017. 7. 12..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

final class InterestRestaurantList: UIViewController {
    
    //MARK : Properties
    var interestRestaurant: [InterestRestaurant] = [] /*{
        didSet {
            self.saveAll()
        }
    }
    */
    
    //MARK: UI
    fileprivate let tableView = UITableView(frame: .zero, style: .plain)
    
    //MARK: init
    init() {
        super.init(nibName: nil, bundle: nil)
        //데이터 임시 처리
        self.interestRestaurant.append(InterestRestaurant(id: "1", name: "한라시그마 구내식당", address: "경기도 성남시 중원구 둔춘대로 545"))
        self.interestRestaurant.append(InterestRestaurant(id: "2", name: "벽산 구내식당", address: "경기도 성남시 중원구 둔춘대로 경기도 성남시 중원구 둔춘대로 경기도 성남시 중원구 둔춘대로 경기도 성남시 545"))
        self.interestRestaurant.append(InterestRestaurant(id: "3", name: "조은 함바", address: "서울시 서초구 서초동 545"))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //MARK : View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "오늘의 짬"
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
        
        self.tableView.register(InterestRestaurantListCell.self, forCellReuseIdentifier: "interestRestaurantListCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(self.tableView)
        
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    //MARK : ACTION
    func editButtonDidTap() {
    }
    
    func addButtonDidTap() {
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60 //cell height
    }
}

