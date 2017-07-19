//
//  BusinessUsersSideDish.swift
//  JJam
//
//  Created by admin on 2017. 7. 19..
//  Copyright © 2017년 admin. All rights reserved.
//


import UIKit

final class BusinessUsersSideDish: UIViewController {
    //MARK: Properties
    var didSetupConstraints = false
    var businessUsersMenu: [BusinessUsersMenu] = [] /*{
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
        
        self.title = "반찬"
        //self.tabBarItem.image = UIImage(named: "tab-stapleFood")
        //self.tabBarItem.selectedImage = UIImage(named: "tab-stapleFood-selected")
        
        //데이터 임시 처리
        self.businessUsersMenu.append(BusinessUsersMenu(id: "1", code: "2", food: "김치"))
        self.businessUsersMenu.append(BusinessUsersMenu(id: "1", code: "2", food: "불고기"))
        self.businessUsersMenu.append(BusinessUsersMenu(id: "1", code: "2", food: "김"))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelButtonDidTap)
        )
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(editButtonDidTap)
        )
        
        UICommonSetTextFieldEnable(self.textField, placeholderText:"반찬")
        self.textField.addTarget(self, action: #selector(textFieldDidChangeText), for: .editingChanged)
        
        UICommonSetButton(self.button, setTitleText: "등록", colorInt: 1)
        self.button.addTarget(self, action: #selector(savaButtonDidTap), for: .touchUpInside)
        
        self.tableView.register(BusinessUsersMenuCell.self, forCellReuseIdentifier: "businessUsersMenuCell")
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
    //MARK: ACTION
    func cancelButtonDidTap() {
        AppDelegate.instance?.BusinessUsersTabBarScreen(selectIndex: 1)
    }
    
    func editButtonDidTap() {
        guard !self.businessUsersMenu.isEmpty else { return }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonDidTap)
        )
        self.tableView.setEditing(true, animated: true)
    }
    
    func doneButtonDidTap() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(editButtonDidTap)
        )
        self.tableView.setEditing(false, animated: true)
    }
    
    func textFieldDidChangeText(_ textField: UITextField) {
        textField.textColor = .black
    }
    func savaButtonDidTap() {
        guard let name = self.textField.text, !name.isEmpty else {
            UICommonSetShakeTextField(self.textField)
            self.textField.becomeFirstResponder()
            return
        }
        
        //데이터 임시 처리
        self.businessUsersMenu.append(BusinessUsersMenu(id: "1", code: "2", food: "콩자반"))
        self.tableView.reloadData()
    }
}
