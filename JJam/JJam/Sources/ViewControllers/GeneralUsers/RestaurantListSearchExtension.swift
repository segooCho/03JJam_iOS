//
//  RestaurantListSearchExtension.swift
//  JJam
//
//  Created by admin on 2017. 7. 18..
//  Copyright © 2017년 admin. All rights reserved.
//


import UIKit

extension RestaurantListSearch: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restaurantSearch.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantListSearchCell", for: indexPath) as! RestaurantListSearchCell
        cell.configure(restaurantSearch: self.restaurantSearch[indexPath.item])
        return cell
    }
}

extension RestaurantListSearch: UITableViewDelegate {
    //cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FixedCommonSet.tableViewCellHeight100
    }
    
    //cell 선택
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath)가 선택!")
        var restaurantSearch = self.restaurantSearch[indexPath.row]
        restaurantSearch.isDone = !restaurantSearch.isDone
        self.restaurantSearch[indexPath.row] = restaurantSearch
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
