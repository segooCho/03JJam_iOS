//
//  BusinessUsersSideDishExtension.swift
//  JJam
//
//  Created by admin on 2017. 7. 19..
//  Copyright © 2017년 admin. All rights reserved.
//


import UIKit

extension BusinessUsersSideDish: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.businessUsersMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "businessUsersMenuCell", for: indexPath) as! BusinessUsersMenuCell
        cell.configure(businessUsersMenu: self.businessUsersMenu[indexPath.item])
        return cell
    }
}

extension BusinessUsersSideDish: UITableViewDelegate {
    //cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FixedCommonSet.tableViewCellHeight
    }
    
    //cell 선택
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath)가 선택!")
        var businessUsersMenu = self.businessUsersMenu[indexPath.row]
        businessUsersMenu.isDone = !businessUsersMenu.isDone
        self.businessUsersMenu[indexPath.row] = businessUsersMenu
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    //삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        self.businessUsersMenu.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        //TODO :: 저장 필요
    }
    
}
