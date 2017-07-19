//
//  BusinessUsersMealDetailExtension.swift
//  JJam
//
//  Created by admin on 2017. 7. 19..
//  Copyright © 2017년 admin. All rights reserved.
//


import UIKit

extension BusinessUsersMealDetail: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "businessUsersMealDetailImageCell", for: indexPath) as! BusinessUsersMealDetailImageCell
            cell.configure(businessUsersMealDetailImageString: self.businessUsersDetail[0].imageString)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "businessUsersMealDetailTextCell", for: indexPath) as! BusinessUsersMealDetailTextCell
            cell.configure(businessUsersDetail: self.businessUsersDetail[0])
            return cell
        }
    }
}

extension BusinessUsersMealDetail: UITableViewDelegate {
    //cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return MealDetailImageCell.height(width: tableView.frame.width)
        } else {
            return MealDetailTextCell.height()
        }
    }
}


