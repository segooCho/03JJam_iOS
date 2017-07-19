//
//  MealDetailExtension.swift
//  JJam
//
//  Created by admin on 2017. 7. 17..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

extension MealDetail: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "mealDetailImageCell", for: indexPath) as! MealDetailImageCell
            cell.configure(mealDetailImageString: self.detail[0].imageString)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "mealDetailTextCell", for: indexPath) as! MealDetailTextCell
            cell.configure(detail: self.detail[0])
            return cell
        }
    }
}

extension MealDetail: UITableViewDelegate {
    //cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return MealDetailImageCell.height(width: tableView.frame.width)
        } else {
            return MealDetailTextCell.height()
        }
    }
}


