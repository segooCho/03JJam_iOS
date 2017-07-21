//
//  BusinessUsersSignUpExtension.swift
//  JJam
//
//  Created by admin on 2017. 7. 20..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

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

