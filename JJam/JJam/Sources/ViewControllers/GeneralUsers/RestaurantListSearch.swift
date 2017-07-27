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
    fileprivate var didSetupConstraints = false
    fileprivate var restaurantSearch: [RestaurantSearch] = []
    fileprivate var interestRestaurant: [InterestRestaurant] = []
    
    //MARK: UI
    fileprivate let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
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
        self.textField.delegate = self
        
        UICommonSetButton(self.button, setTitleText: "찾기", colorInt: 0)
        self.button.addTarget(self, action: #selector(searchButtonDidTap), for: .touchUpInside)

        self.tableView.register(RestaurantListSearchCell.self, forCellReuseIdentifier: "restaurantListSearchCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self

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
            self.activityIndicatorView.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
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
                make.left.right.equalToSuperview()
                make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
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
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func addButtonDidTap() {
        for data in self.restaurantSearch {
            if (data.isDone){
                self.interestRestaurant.append(InterestRestaurant(_id: data._id!, companyName: data.companyName!))
            }
        }
        NotificationCenter.default.post(name: .interestRestaurantDidAdd, object: self, userInfo: ["interestRestaurant": self.interestRestaurant])
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func textFieldDidChangeText(_ textField: UITextField) {
        textField.textColor = .black
    }
    
    func searchButtonDidTap() {
        guard let name = self.textField.text, !name.isEmpty else {
            UICommonSetShakeTextField(self.textField)
            return
        }
        self.textField.resignFirstResponder() //키보드 숨기기
        self.activityIndicatorView.startAnimating()
        GeneralUsersNetWorking.restaurantSearch(searchText: self.textField.text!) { [weak self] response in
            guard let `self` = self else { return }
            self.activityIndicatorView.stopAnimating()
            if response.count > 0 {
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
                            // 확인 후 작업
                    }
                    alertController.addAction(alertConfirm)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
            }
            self.restaurantSearch = response
            self.tableView.reloadData()
        }
    }
}


extension RestaurantListSearch: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restaurantSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantListSearchCell", for: indexPath) as! RestaurantListSearchCell
        cell.configure(restaurantSearch: self.restaurantSearch[indexPath.item])
        return cell
    }
}

extension RestaurantListSearch: UITableViewDelegate {
    //cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FixedCommonSet.tableViewCellHeight100
    }
    
    //cell 선택
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("\(indexPath)가 선택!")
        var restaurantSearch = self.restaurantSearch[indexPath.row]
        restaurantSearch.isDone = !restaurantSearch.isDone
        self.restaurantSearch[indexPath.row] = restaurantSearch
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

extension RestaurantListSearch: UITextFieldDelegate {
    //TextField 리턴키 처리
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchButtonDidTap()
        return true
    }
}
