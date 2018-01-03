//
//  BoardCell.swift
//  JJam
//
//  Created by admin on 2018. 1. 3..
//  Copyright © 2018년 admin. All rights reserved.
//

import UIKit

final class BoardCell: UITableViewCell {
    //MARK: init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: configure
    func configure(boardInfo: BoardInfo) {
        self.backgroundColor = .white
        
        self.textLabel?.text = "(" + boardInfo.division + ") " + boardInfo.title
        if boardInfo.answer == "" {
            self.detailTextLabel?.text = "답변 : 준비중"
        } else {
            self.detailTextLabel?.text = "답변 : 완료"
        }
        self.accessoryType = .disclosureIndicator
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}
