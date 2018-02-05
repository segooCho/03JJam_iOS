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
    fileprivate let restaurant_Id: String
    fileprivate var didSetupConstraints = false
    fileprivate var segmentedIndexAndCode = 0
    fileprivate var groupText:String = "location"
    fileprivate var group: [Group] = []
    fileprivate var groupSort: [Group] = []

    
    //MARK: Constants
    fileprivate struct Metric {
        static let segmentedMid = CGFloat(5)
        static let segmentedHeight = CGFloat(45)
        
        static let textFieldMid = CGFloat(10)
        static let textFieldHeight = CGFloat(40)
        
        static let commonOffset = CGFloat(7)
    }

    
    //MARK: UI
    fileprivate let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    fileprivate let segmentedControl = UISegmentedControl()
    fileprivate let segmentedTitles: Array<String> = ["위치","구분","주식(밥,면)","국","반찬","후식"]
    fileprivate let textField = UITextField()
    fileprivate let button = UIButton()
    fileprivate let tableView = UITableView(frame: .zero, style: .plain)
    
    //NotificationCenter에 등록된 옵저버의 타겟 객체가 소멸
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: init
    init(restaurant_Id: String) {
        self.restaurant_Id = restaurant_Id
        super.init(nibName: nil, bundle: nil)
        
        self.title = "메뉴관리"
        self.tabBarItem.image = UIImage(named: "tab-stapleFood")
        self.tabBarItem.selectedImage = UIImage(named: "tab-stapleFood-selected")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewResizerOnKeyboardShown()
        
        self.view.backgroundColor = .white
        
        self.navigationController?.navigationBar.barTintColor = .orange
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "편집",
            style: .done,
            target: self,
            action: #selector(editButtonDidTap)
        )
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "등록 하기",
            style: .done,
            target: self,
            action: #selector(addButtonDidTap)
        )
        self.navigationItem.rightBarButtonItem?.tintColor = .white

        UICommonSetLoading(self.activityIndicatorView)
        //segmentedControl
        UICommonSetSegmentedControl(self.segmentedControl, titles: segmentedTitles, font: 1)
        self.segmentedControl.addTarget(self, action: #selector(changeSegmentedControl), for: .valueChanged)
        self.segmentedControl.selectedSegmentIndex = self.segmentedIndexAndCode
        
        //textField
        groupBind(groupArray: BusinessGroupArray.location)
        UICommonSetTextFieldEnable(self.textField, placeholderText: self.segmentedTitles[self.segmentedIndexAndCode])
        self.textField.addTarget(self, action: #selector(textFieldDidChangeText), for: .editingChanged)
        self.textField.delegate = self
        
        self.tableView.register(BusinessUsersMenuCell.self, forCellReuseIdentifier: "businessUsersMenuCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.view.addSubview(self.segmentedControl)
        self.view.addSubview(self.textField)
        self.view.addSubview(self.button)
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.activityIndicatorView)
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
            self.activityIndicatorView.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            self.segmentedControl.snp.makeConstraints { make in
                make.left.equalTo(Metric.segmentedMid)
                make.right.equalTo(-Metric.segmentedMid)
                make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(Metric.commonOffset)
                make.height.equalTo(Metric.segmentedHeight)
            }
            self.textField.snp.makeConstraints { make in
                make.left.equalTo(Metric.textFieldMid)
                make.right.equalTo(-Metric.textFieldMid)
                make.top.equalTo(self.segmentedControl.snp.bottom).offset(Metric.commonOffset)
                make.height.equalTo(Metric.textFieldHeight)
            }
            self.tableView.snp.makeConstraints { make in
                make.top.equalTo(self.textField.snp.bottom).offset(Metric.commonOffset)
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
        self.textField.text = ""
        self.segmentedIndexAndCode = segmentedControl.selectedSegmentIndex
        self.textField.placeholder = self.segmentedTitles[self.segmentedIndexAndCode]
        self.group.removeAll()
        switch self.segmentedControl.selectedSegmentIndex {
        case 0:
            self.groupBind(groupArray: BusinessGroupArray.location)
            self.groupText = "location"
            self.doneButtonDidTap()
        case 1:
            self.groupBind(groupArray: BusinessGroupArray.division)
            self.groupText = "division"
            self.doneButtonDidTap()
        case 2:
            self.groupBind(groupArray: BusinessGroupArray.stapleFood)
            self.groupText = "stapleFood"
            self.doneButtonDidTap()
        case 3:
            self.groupBind(groupArray: BusinessGroupArray.soup)
            self.groupText = "soup"
            self.doneButtonDidTap()
        case 4:
            self.groupBind(groupArray: BusinessGroupArray.sideDish)
            self.groupText = "sideDish"
            self.doneButtonDidTap()
        case 5:
            self.groupBind(groupArray: BusinessGroupArray.dessert)
            self.groupText = "dessert"
            self.doneButtonDidTap()
        default:
            print("Group 없음")
        }
        
        self.tableView.reloadData()
    }
    
    func groupBind(groupArray: NSMutableArray) {
        for data in groupArray {
            self.group.append(Group (text: data as! String))
        }
    }
    
    func editButtonDidTap() {
        guard !self.group.isEmpty else { return }
        if self.group.count <= 1 {
            let alertController = UIAlertController(
                title: self.title,
                message: "1개 이상의 " + self.segmentedTitles[self.segmentedIndexAndCode] + " 정보는 존재해야 합니다.",
                preferredStyle: .alert
            )
            let alertConfirm = UIAlertAction(
                title: "확인",
                style: .default) { _ in
            }
            alertController.addAction(alertConfirm)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "완료",
            style: .done,
            target: self,
            action: #selector(doneButtonDidTap)
        )
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        self.tableView.setEditing(true, animated: true)
    }
    
    func doneButtonDidTap() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "편집",
            style: .done,
            target: self,
            action: #selector(editButtonDidTap)
        )
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        self.tableView.setEditing(false, animated: true)
    }
   
    func addButtonDidTap() {
        let text = self.textField.text!
        if text.isEmpty {
            UICommonSetShakeTextField(self.textField)
            return
        }
        
        if text.characters.count < 2 {
            UICommonSetShakeTextField(self.textField)
            return
        }
        
        //중복 확인
        for data in self.group {
            if text == data.text {
                let alertController = UIAlertController(
                    title: self.title,
                    message: text + " 이미 등록된 " + self.segmentedTitles[self.segmentedIndexAndCode] + " 정보입니다.",
                    preferredStyle: .alert
                )
                let alertConfirm = UIAlertAction(
                    title: "확인",
                    style: .default) { _ in
                        // 확인 후 작업
                        self.textField.becomeFirstResponder()
                }
                alertController.addAction(alertConfirm)
                self.present(alertController, animated: true, completion: nil)
                return
            }
        }

        
        //구분에서 '아침','점심','저녁' 으로 시작하는 문제 지정
        if segmentedIndexAndCode == 1 && text != "사진식단" {
            var check:Bool = false
            let checkText = text.substring(to: text.index(text.startIndex,  offsetBy: 2))
            
            if checkText == "아침" || checkText == "점심" || checkText == "저녁" {
                check = true
            }
            
            if !check {
                let alertController = UIAlertController(
                    title: self.title,
                    message: "구분은 '아침','점심','저녁'으로 시작하는 문자열 또는 '사진식단' 만 입력하세요.\n예)'점심-A' 또는 '점심-간편식' 또는 '사진식단' 등",
                    preferredStyle: .alert
                )
                let alertConfirm = UIAlertAction(
                    title: "확인",
                    style: .default) { _ in
                        // 확인 후 작업
                        self.textField.becomeFirstResponder()
                }
                alertController.addAction(alertConfirm)
                self.present(alertController, animated: true, completion: nil)
                return
            }
        }
            
        self.restaurantGroupAddAndDel(text:self.textField.text!, addMode: true)
    }

    //식당 Group 추가 & 삭제
    func restaurantGroupAddAndDel(text:String, addMode: Bool) {
        UICommonSetLoadingService(self.activityIndicatorView, service: true)
        BusinessUsersNetWorking.restaurantGroupAddAndDel(restaurant_Id: self.restaurant_Id, group: self.groupText, text: text, addMode: addMode) { [weak self] response in
            guard let `self` = self else { return }
            if response.count > 0 {
                UICommonSetLoadingService(self.activityIndicatorView, service: false)
                let message = response[0].message
                if message != nil {
                    let alertController = UIAlertController(
                        title: self.title,
                        message: message,
                        preferredStyle: .alert
                    )
                    let alertConfirm = UIAlertAction(
                        title: "확인",
                        style: .default) { _ in
                            if message == "저장이 완료되었습니다." {
                                self.group.append(Group (text: text))
                                //임시 sort
                                self.groupSort.removeAll()
                                for data in self.group {
                                    self.groupSort.append(Group (text: data.text))
                                }
                                self.groupSort.sort {$0.text < $1.text}

                                switch self.groupText {
                                case "location":
                                    BusinessGroupArray.location.removeAllObjects()
                                    self.compareTextPlacement(group: self.groupText)
                                case "division":
                                    BusinessGroupArray.division.removeAllObjects()
                                    self.compareTextPlacement(group: self.groupText)
                                case "stapleFood":
                                    BusinessGroupArray.stapleFood.removeAllObjects()
                                    self.compareTextPlacement(group: self.groupText)
                                case "soup":
                                    BusinessGroupArray.soup.removeAllObjects()
                                    self.compareTextPlacement(group: self.groupText)
                                case "sideDish":
                                    BusinessGroupArray.sideDish.removeAllObjects()
                                    self.compareTextPlacement(group: self.groupText)
                                case "dessert":
                                    BusinessGroupArray.dessert.removeAllObjects()
                                    self.compareTextPlacement(group: self.groupText)
                                default:
                                    print("No Group")
                                }
                                self.textField.text = ""
                                self.tableView.reloadData()
                            } else if message == "삭제가 완료되었습니다." {
                                self.group.removeAll()
                                switch self.groupText {
                                case "location":
                                    BusinessGroupArray.location.remove(text)
                                    self.groupBind(groupArray: BusinessGroupArray.location)
                                case "division":
                                    BusinessGroupArray.division.remove(text)
                                    self.groupBind(groupArray: BusinessGroupArray.division)
                                case "stapleFood":
                                    BusinessGroupArray.stapleFood.remove(text)
                                    self.groupBind(groupArray: BusinessGroupArray.stapleFood)
                                case "soup":
                                    BusinessGroupArray.soup.remove(text)
                                    self.groupBind(groupArray: BusinessGroupArray.soup)
                                case "sideDish":
                                    BusinessGroupArray.sideDish.remove(text)
                                    self.groupBind(groupArray: BusinessGroupArray.sideDish)
                                case "dessert":
                                    BusinessGroupArray.dessert.remove(text)
                                    self.groupBind(groupArray: BusinessGroupArray.dessert)
                                default:
                                    print("No Group")
                                }
                                self.doneButtonDidTap()
                                self.tableView.reloadData()
                            }
                    }
                    alertController.addAction(alertConfirm)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    func compareTextPlacement(group:String) {
        self.group.removeAll()
        for data in self.groupSort {
            switch group {
            case "location":
                BusinessGroupArray.location.add(data.text)
                self.group.append(Group (text: data.text))
            case "division":
                BusinessGroupArray.division.add(data.text)
                self.group.append(Group (text: data.text))
            case "stapleFood":
                BusinessGroupArray.stapleFood.add(data.text)
                self.group.append(Group (text: data.text))
            case "soup":
                BusinessGroupArray.soup.add(data.text)
                self.group.append(Group (text: data.text))
            case "sideDish":
                BusinessGroupArray.sideDish.add(data.text)
                self.group.append(Group (text: data.text))
            case "dessert":
                BusinessGroupArray.dessert.add(data.text)
                self.group.append(Group (text: data.text))
            default:
                print("No Group")
            }
        }
        self.groupSort.removeAll()
    }
    
    func textFieldDidChangeText(_ textField: UITextField) {
        textField.textColor = .black
    }
    
    /*
    func savaButtonDidTap() {
        guard let name = self.textField.text, !name.isEmpty else {
            UICommonSetShakeTextField(self.textField)
            return
        }
        
        //데이터 임시 처리
        self.businessUsersMenu.append(BusinessUsersMenu(id: "1", code: "0", food: "잡곡"))
        self.tableView.reloadData()
    }
    */
}


extension BusinessUsersMenuManagement: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.group.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "businessUsersMenuCell", for: indexPath) as! BusinessUsersMenuCell
        cell.configure(group: self.group[indexPath.item])
        return cell
    }
}

extension BusinessUsersMenuManagement: UITableViewDelegate {
    //cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SuperConstants.tableViewCellHeight
    }
    
    //삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        /*
        if (segmentedIndexAndCode == 1 && self.group[indexPath.row].text == "사진식단") {
            let alertController = UIAlertController(
                title: self.title,
                message: "'사진식단'은 삭제할수 없습니다.",
                preferredStyle: .alert
            )
            let alertConfirm = UIAlertAction(
                title: "확인",
                style: .default) { _ in
                    self.doneButtonDidTap()
            }
            alertController.addAction(alertConfirm)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        */
        self.restaurantGroupAddAndDel(text:self.group[indexPath.row].text, addMode: false)
    }
}

extension BusinessUsersMenuManagement: UITextFieldDelegate {
    //TextField 리턴키 처리
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

//키보드 상태로 인해 숨겨지는 영역 처리
extension UIViewController {
    func setupViewResizerOnKeyboardShown() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShowForResizing),
                                               name: Notification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHideForResizing),
                                               name: Notification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    func keyboardWillShowForResizing(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let window = self.view.window?.frame {
            self.view.frame = CGRect(x: self.view.frame.origin.x,
                                     y: self.view.frame.origin.y,
                                     width: self.view.frame.width,
                                     height: window.origin.y + window.height - keyboardSize.height)
        } else {
            debugPrint("We're showing the keyboard and either the keyboard size or window is nil: panic widely.")
        }
    }
    
    func keyboardWillHideForResizing(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let viewHeight = self.view.frame.height
            self.view.frame = CGRect(x: self.view.frame.origin.x,
                                     y: self.view.frame.origin.y,
                                     width: self.view.frame.width,
                                     height: viewHeight + keyboardSize.height)
        } else {
            debugPrint("We're about to hide the keyboard and the keyboard size is nil. Now is the rapture.")
        }
    }
    
}
