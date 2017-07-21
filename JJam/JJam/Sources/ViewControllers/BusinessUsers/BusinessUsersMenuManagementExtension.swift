//
//  BusinessUsersMenuManagementExtension.swift
//  JJam
//
//  Created by admin on 2017. 7. 20..
//  Copyright © 2017년 admin. All rights reserved.
//


import UIKit

extension BusinessUsersMenuManagement: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "businessUsersMenuCell", for: indexPath) as! BusinessUsersMenuCell
        cell.configure(menu: self.menu[indexPath.item])
        return cell
    }
}

extension BusinessUsersMenuManagement: UITableViewDelegate {
    //cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FixedCommonSet.tableViewCellHeight
    }
    
    //cell 선택
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath)가 선택!")
        var menu = self.menu[indexPath.row]
        menu.isDone = !menu.isDone
        self.menu[indexPath.row] = menu
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    //삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        self.menu.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        //TODO :: 저장 필요
    }
    
}

