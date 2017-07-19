//
//  BusinessUsersMealListExtension.swift
//  JJam
//
//  Created by admin on 2017. 7. 18..
//  Copyright © 2017년 admin. All rights reserved.
//


import UIKit

extension BusinessUsersMealList: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.businessUsersMeal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "businessUsersMealListCell", for: indexPath) as! BusinessUsersMealListCell
        cell.configure(businessUsersMeal: self.businessUsersMeal[indexPath.item])
        return cell
    }
}

extension BusinessUsersMealList: UITableViewDelegate {
    //선택
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath)가 선택!")
        //NavigationController pushViewController
        let businessUsersMealDetail = BusinessUsersMealDetail(businessUsersMealDetailId: self.businessUsersMeal[indexPath.row].id)
        self.navigationController?.pushViewController(businessUsersMealDetail, animated: true)
    }
    
    //cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FixedCommonSet.tableViewCellHeight
    }

}

