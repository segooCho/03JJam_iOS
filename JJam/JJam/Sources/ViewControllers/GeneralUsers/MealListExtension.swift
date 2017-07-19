//
//  MealListExtension.swift
//  JJam
//
//  Created by admin on 2017. 7. 15..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

extension MealList: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.meal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealListCell", for: indexPath) as! MealListCell
        cell.configure(meal: self.meal[indexPath.item])
        return cell
    }
}

extension MealList: UITableViewDelegate {
    //선택
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath)가 선택!")
        //NavigationController pushViewController
        let mealDetail = MealDetail(mealDetailId: self.meal[indexPath.row].id)
        self.navigationController?.pushViewController(mealDetail, animated: true)
    }
    
    //cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FixedCommonSet.tableViewCellHeight
    }
}

