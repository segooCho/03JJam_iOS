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
    fileprivate var didSetupConstraints = false
    fileprivate var signUp: [SignUp] = []
    
    //MARK: UI
    fileprivate let tableView = UITableView(frame: .zero, style: .plain)
    
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

        self.tableView.register(BusinessUsersSignUpTextCell.self, forCellReuseIdentifier: "businessUsersSignUpTextCell")
        self.tableView.register(BusinessUsersSignUpImageCell.self, forCellReuseIdentifier: "businessUsersSignUpImageCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(self.tableView)
        //updateViewConstraints 자동 호출
        self.view.setNeedsUpdateConstraints()
    }
    
    //MARK: 애플 추천 방식으로 한번만 화면을 그리도록 한다.
    //setNeedsUpdateConstraints() 필요
    override func updateViewConstraints() {
        if !self.didSetupConstraints {
            self.didSetupConstraints = true
            self.tableView.snp.makeConstraints { make in
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
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func addButtonDidTap() {
        //AppDelegate.instance?.LoginScreen()
        //TODO :: 저장

        let index = IndexPath(row: 0, section: 0)
        let cell: BusinessUsersSignUpTextCell = self.tableView.cellForRow(at: index) as! BusinessUsersSignUpTextCell
        cell.setInputData()
        
        
        print("id : ", BusinessUsersSignUpTextCell.signUp.id)
        print("address : ", BusinessUsersSignUpTextCell.signUp.address)
        
    }

}


extension BusinessUsersSignUp: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "businessUsersSignUpTextCell", for: indexPath) as! BusinessUsersSignUpTextCell
            cell.configure(signUp: self.signUp[0])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "businessUsersSignUpImageCell", for: indexPath) as! BusinessUsersSignUpImageCell
            cell.configure(signUpImageString: self.signUp[0].imageString)
            return cell
        }
    }
}

extension BusinessUsersSignUp: UITableViewDelegate {
    //cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return BusinessUsersSignUpTextCell.height()
        } else {
            return BusinessUsersSignUpImageCell.height(width: tableView.frame.width)
        }
    }
}



