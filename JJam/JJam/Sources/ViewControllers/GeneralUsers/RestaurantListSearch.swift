//
//  RestaurantListSearch.swift
//  JJam
//
//  Created by admin on 2017. 7. 17..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

final class RestaurantListSearch: UIViewController {
    //MARK: Properties
    var didSetupConstraints = false
    var restaurantSearch: [RestaurantSearch] = [] /*{
     didSet {
     self.saveAll()
     }
     }
     */
    
    //MARK: UI
    fileprivate let textField = UITextField()
    fileprivate let button = UIButton()
    fileprivate let tableView = UITableView(frame: .zero, style: .plain)
    
    
    //MARK: init
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "식당 찾기"
        self.view.backgroundColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelButtonDidTap)
        )
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonDidTap)
        )
        
        UICommonSetTextFieldEnable(self.textField, placeholderText:"상호 or 주소(읍,면,동)")
        self.textField.addTarget(self, action: #selector(textFieldDidChangeText), for: .editingChanged)
        
        UICommonSetButton(self.button, setTitleText: "찾기", colorInt: 0)
        self.button.addTarget(self, action: #selector(searchButtonDidTap), for: .touchUpInside)

        self.tableView.register(RestaurantListSearchCell.self, forCellReuseIdentifier: "restaurantListSearchCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self

        self.view.addSubview(self.textField)
        self.view.addSubview(self.button)
        self.view.addSubview(self.tableView)
        //updateViewConstraints 자동 호출
        self.view.setNeedsUpdateConstraints()
    }
    
    //MARK: 애플 추천 방식으로 한번만 화면을 그리도록 한다.
    //setNeedsUpdateConstraints() 필요
    override func updateViewConstraints() {
        if !self.didSetupConstraints {
            self.didSetupConstraints = true
            self.textField.snp.makeConstraints { make in
                make.left.equalTo(10)
                make.right.equalTo(-130)
                make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(5)
                make.height.equalTo(30)
            }
            self.button.snp.makeConstraints { make in
                make.left.equalTo(250)
                make.right.equalTo(-10)
                make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(5)
                make.height.equalTo(30)
            }
            self.tableView.snp.makeConstraints { make in
                make.top.equalTo(self.textField.snp.bottom).offset(3)
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
    func cancelButtonDidTap() {
        AppDelegate.instance?.GeneralUsersTabBarScreen(selectIndex: 0)
    }
    
    func addButtonDidTap() {
        AppDelegate.instance?.GeneralUsersTabBarScreen(selectIndex: 0)
    }
    
    func textFieldDidChangeText(_ textField: UITextField) {
        textField.textColor = .black
    }
    
    func searchButtonDidTap() {
        /*
        guard let name = self.textField.text, !name.isEmpty else {
            UICommonSetShakeTextField(self.textField)
            self.textField.becomeFirstResponder()
            return
        }
        */
        
        //데이터 임시 처리
        self.restaurantSearch.append(RestaurantSearch(id: "1", companyName: "한라시그마 구내식당", certification: "Y", address: "경기도 성남시 중원구 둔춘대로 545", contactNumber: "031-111-3344", representative: "홍길동"))
        self.restaurantSearch.append(RestaurantSearch(id: "2", companyName: "벽산 구내식당", certification: "N", address: "경기도 성남시 중원구 둔춘대로 5666", contactNumber: "010-8888-9999", representative: "김갑"))
        
        self.tableView.reloadData()
    }
}
