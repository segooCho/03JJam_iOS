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
    
    //MARK: Constants
    fileprivate struct Metric {
        static let labelLeft = CGFloat(10)
        static let labelRight = CGFloat(-130)
        
        static let buttonLeft = CGFloat(250)
        static let buttonRight = CGFloat(-10)
        
        static let commonOffset = CGFloat(7)
        static let commonHeight = CGFloat(45)
    }
    
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
        //scroll의 내부 여백 발생시 사용()
        //self.automaticallyAdjustsScrollViewInsets = false

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
        //self.textField.isUserInteractionEnabled = true;
        
        UICommonSetButton(self.button, setTitleText: "찾기", color: 0)
        self.button.addTarget(self, action: #selector(searchButtonDidTap), for: .touchUpInside)

        self.tableView.register(RestaurantListSearchCell.self, forCellReuseIdentifier: "restaurantListSearchCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self

        //self.activityIndicatorView.hidesWhenStopped = true
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
            self.textField.snp.makeConstraints { make in
                make.left.equalTo(Metric.labelLeft)
                make.right.equalTo(Metric.labelRight)
                make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(Metric.commonOffset)
                make.height.equalTo(Metric.commonHeight)
            }
            self.button.snp.makeConstraints { make in
                make.left.equalTo(Metric.buttonLeft)
                make.right.equalTo(Metric.buttonRight)
                make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(Metric.commonOffset)
                make.height.equalTo(Metric.commonHeight)
            }
            self.tableView.snp.makeConstraints { make in
                make.top.equalTo(self.textField.snp.bottom).offset(Metric.commonOffset)
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
        var isCheck = false
        for data in self.restaurantSearch {
            if (data.isDone){
                self.interestRestaurant.append(InterestRestaurant(_id: data._id!, companyName: data.companyName!))
                isCheck = true
            }
        }
        if !isCheck {
            let alertController = UIAlertController(
                title: self.title,
                message: "체크된 식당 정보가 없습니다.",
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
        UICommonSetLoading(self.activityIndicatorView, service: true)
        GeneralUsersNetWorking.restaurantSearch(searchText: self.textField.text!) { [weak self] response in
            guard let `self` = self else { return }
            if response.count > 0 {
                UICommonSetLoading(self.activityIndicatorView, service: false)
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
                            self.textField.becomeFirstResponder()
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
        self.view.endEditing(true)
        //searchButtonDidTap()
        //화면 터치 이벤트가 발생하지 않음으로 기존 다음 작업 처리에서 키보드 닫기호 활용
        //override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {}
        //self.view.userInteractionEnabled = true => 소용 없음!!!
        return true
    }
}
