//
//  BusinessUsersMenuManagement.swift
//  JJam
//
//  Created by admin on 2017. 7. 20..
//  Copyright © 2017년 admin. All rights reserved.
//


import UIKit

final class BusinessUsersMenuManagement: UIViewController {
    //MARK: Properties
    var didSetupConstraints = false
    var segmentedIndexAndCode: Int
    var segmentedIndexPlaceholderText = ""
    var menu: [Menu] = [] /*{
     didSet {
     self.saveAll()
     }
     }
     */
    
    //MARK: UI
    fileprivate let segmentedControl = UISegmentedControl()
    fileprivate let segmentedTitles: Array<String> = ["주식(밥,면)","국","반찬","후식"]
    fileprivate let textField = UITextField()
    fileprivate let button = UIButton()
    fileprivate let tableView = UITableView(frame: .zero, style: .plain)
    
    
    //MARK: init
    init(segmentedIndexAndCode: Int) {
        self.segmentedIndexAndCode = segmentedIndexAndCode
        super.init(nibName: nil, bundle: nil)
        
        self.title = "메뉴관리"
        self.tabBarItem.image = UIImage(named: "tab-stapleFood")
        self.tabBarItem.selectedImage = UIImage(named: "tab-stapleFood-selected")
        //데이터 임시 처리
        self.menu.append(Menu(id: "1", code: "0", food: "현미밥"))
        self.menu.append(Menu(id: "1", code: "0", food: "보리밥"))
        self.menu.append(Menu(id: "1", code: "0", food: "짜장면"))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
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

        
        switch self.segmentedIndexAndCode {
        case 0:
            self.segmentedIndexPlaceholderText = "주식(밥,명)"
        case 1:
            self.segmentedIndexPlaceholderText = "국"
        case 2:
            self.segmentedIndexPlaceholderText = "반찬"
        case 3:
            self.segmentedIndexPlaceholderText = "후식"
        default:
            self.segmentedIndexPlaceholderText = ""
        }
        
        //segmentedControl
        UICommonSetSegmentedControl(self.segmentedControl, titles: segmentedTitles)
        self.segmentedControl.addTarget(self, action: #selector(changeSegmentedControl), for: .valueChanged)
        self.segmentedControl.selectedSegmentIndex = self.segmentedIndexAndCode
        
        //textField
        UICommonSetTextFieldEnable(self.textField, placeholderText: self.segmentedIndexPlaceholderText)
        self.textField.addTarget(self, action: #selector(textFieldDidChangeText), for: .editingChanged)
        
        self.tableView.register(BusinessUsersMenuCell.self, forCellReuseIdentifier: "businessUsersMenuCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.view.addSubview(self.segmentedControl)
        self.view.addSubview(self.textField)
        self.view.addSubview(self.button)
        self.view.addSubview(self.tableView)
        //updateViewConstraints 자동 호출
        self.view.setNeedsUpdateConstraints()
    }
    
    //키보드 처리
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.textField.becomeFirstResponder()
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
            self.textField.snp.makeConstraints { make in
                make.left.equalTo(10)
                make.right.equalTo(-10)
                make.top.equalTo(self.segmentedControl.snp.bottom).offset(5)
                make.height.equalTo(30)
            }
            self.tableView.snp.makeConstraints { make in
                make.top.equalTo(self.textField.snp.bottom).offset(3)
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
    
    //view가 안보이다가 다시 보이게 되었을때 발생하는 이벤트
    //TabBar 이동 후 재 선택 시
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true) // No need for semicolon
        if self.didSetupConstraints {
            self.segmentedControl.selectedSegmentIndex = 0
            changeSegmentedControl()
        }
    }

    
    //MARK: ACTION
    func changeSegmentedControl() {
        self.segmentedIndexAndCode = segmentedControl.selectedSegmentIndex

        switch self.segmentedControl.selectedSegmentIndex {
        case 0:
            self.textField.placeholder = "주식(밥,명)"
        case 1:
            self.textField.placeholder = "국"
        case 2:
            self.textField.placeholder = "반찬"
        case 3:
            self.textField.placeholder = "후식"
        default:
            self.textField.placeholder = ""
        }
    }
    
    func editButtonDidTap() {
        guard !self.menu.isEmpty else { return }
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
        guard let name = self.textField.text, !name.isEmpty else {
            UICommonSetShakeTextField(self.textField)
            self.textField.becomeFirstResponder()
            return
        }
        
        //데이터 임시 처리
        self.menu.append(Menu(id: "1", code: "0", food: "잡곡"))
        self.tableView.reloadData()
    }

    func textFieldDidChangeText(_ textField: UITextField) {
        textField.textColor = .black
    }
    
    /*
    func savaButtonDidTap() {
        guard let name = self.textField.text, !name.isEmpty else {
            UICommonSetShakeTextField(self.textField)
            self.textField.becomeFirstResponder()
            return
        }
        
        //데이터 임시 처리
        self.businessUsersMenu.append(BusinessUsersMenu(id: "1", code: "0", food: "잡곡"))
        self.tableView.reloadData()
    }
    */
}

