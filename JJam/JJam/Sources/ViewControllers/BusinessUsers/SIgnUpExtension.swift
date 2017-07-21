//
//  SignUpExtension.swift
//  JJam
//
//  Created by admin on 2017. 7. 20..
//  Copyright © 2017년 admin. All rights reserved.
//


import UIKit

extension SignUp: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "signUpTextCell", for: indexPath) as! SignUpTextCell
            cell.configure(businessUsersDetail: self.businessUsersDetail[0])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "signUpImageCell", for: indexPath) as! SignUpImageCell
            cell.configure(businessUsersMealDetailImageString: self.businessUsersDetail[0].imageString)
            return cell
        }
    }
}

extension SignUp: UITableViewDelegate {
    //cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return MealDetailTextCell.height()
        } else {
            return MealDetailImageCell.height(width: tableView.frame.width)
        }
    }
}

