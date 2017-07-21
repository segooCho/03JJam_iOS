//
//  BusinessUsersSignUp.swift
//  JJam
//
//  Created by admin on 2017. 7. 20..
//  Copyright © 2017년 admin. All rights reserved.
//


import UIKit

final class BusinessUsersSignUp: UIViewController {
    //MARK: Properties
    var didSetupConstraints = false
    var signUp: [SignUp] = [] /*{
     didSet {
     self.saveAll()
     }
     }
     */
    
    //MARK: UI
    fileprivate let detailTableView = UITableView(frame: .zero, style: .plain)
    //fileprivate let progressView = UIProgressView()
    
    //MARK: init
    init() {
        super.init(nibName: nil, bundle: nil)
        //데이터 임시 처리
        self.signUp.append(SignUp(id: "", password: "", password2: "", businessNumber: "",
                                  companyName: "", address: "", contactNumber: "", representative: "", imageString: ""))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "회원 가입"
        
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

        self.detailTableView.register(BusinessUsersSignUpTextCell.self, forCellReuseIdentifier: "businessUsersSignUpTextCell")
        self.detailTableView.register(BusinessUsersSignUpImageCell.self, forCellReuseIdentifier: "businessUsersSignUpImageCell")
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
    
    //MARK: ACTION
    func cancelButtonDidTap() {
        AppDelegate.instance?.LoginScreen()
    }
    
    func addButtonDidTap() {
        AppDelegate.instance?.LoginScreen()
    }
    
    
    
}

