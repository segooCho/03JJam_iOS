//
//  InterestRestaurantListExtension.swift
//  JJam
//
//  Created by admin on 2017. 7. 15..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

extension InterestRestaurantList: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.interestRestaurant.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "interestRestaurantListCell", for: indexPath) as! InterestRestaurantListCell
        cell.configure(interestRestaurant: self.interestRestaurant[indexPath.item])
        return cell
    }
}

extension InterestRestaurantList: UITableViewDelegate {
    //선택
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("\(indexPath)가 선택!")
        AppDelegate.instance?.MealListScreen(id : self.interestRestaurant[indexPath.row].id, name: self.interestRestaurant[indexPath.row].companyName)
    }
    
    //삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        self.interestRestaurant.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        //TODO :: 저장 필요
    }
    
    //위치 이동
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var interestRestaurant = self.interestRestaurant
        let removeTaks = interestRestaurant.remove(at: sourceIndexPath.row)
        interestRestaurant.insert(removeTaks, at: destinationIndexPath.row)
        self.interestRestaurant = interestRestaurant
        //TODO :: 저장 필요 한가??
    }

    
    //cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FixedCommonSet.tableViewCellHeight
    }
}

