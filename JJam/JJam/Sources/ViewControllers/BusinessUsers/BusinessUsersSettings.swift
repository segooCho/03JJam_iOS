//
//  BusinessUsersSettings.swift
//  JJam
//
//  Created by admin on 2017. 7. 18..
//  Copyright © 2017년 admin. All rights reserved.
//

import UIKit

final class BusinessUsersSettings: UIViewController {
    //MARK: Properties
    var didSetupConstraints = false
    
    fileprivate struct Section {
        let items: [SectionItem]
    }
    
    fileprivate enum SectionItem {
        case notice
        case profile
        case logout
    }
    
    fileprivate struct CellData {
        var text: String
        var detailText: String?
    }
    
    fileprivate var sections: [Section] = [
        Section(items: [
            .notice,
            ]),
        Section(items: [
            .profile,
            ]),
        Section(items: [
            .logout,
            ]),
        ]
    
    //MARK: UI
    fileprivate let tableView = UITableView(frame: .zero, style: .grouped)
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "설정"
        self.tabBarItem.image = UIImage(named: "tab-settings")
        self.tabBarItem.selectedImage = UIImage(named: "tab-settings-selected")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(SettingsCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView)
        //updateViewConstraints 자동 호출
        self.view.setNeedsUpdateConstraints()
    }
    
    //MARK: 애플 추천 방식으로 한번만 화면을 그리도록 한다.
    //setNeedsUpdateConstraints() 필요
    override func updateViewConstraints() {
        if !self.didSetupConstraints {
            self.didSetupConstraints = true
            self.tableView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        super.updateViewConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func cellData(for sectionItem: SectionItem) -> CellData {
        switch sectionItem {
        case .notice:
            return CellData(text: "공지사항", detailText: nil)
        case .profile:
            return CellData(text: "회원정보", detailText: nil)
        case .logout:
            return CellData(text: "로그아웃", detailText: nil)
        }
    }
}

extension BusinessUsersSettings: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let sectionItem = self.sections[indexPath.section].items[indexPath.row]
        let cellData = self.cellData(for: sectionItem)
        cell.textLabel?.text = cellData.text
        cell.detailTextLabel?.text = cellData.detailText
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
}

extension BusinessUsersSettings: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) //버튼이 원 상태로(누림 후 원래 상태로)
        let sectionItem = self.sections[indexPath.section].items[indexPath.row]
        switch sectionItem {
        case .notice:
            AppDelegate.instance?.BusinessUsersNoticeScreen()
        case .profile:
            break
        case .logout:
            let actionSheet = UIAlertController(
                title: "로그아웃 하시겠습니까?",
                message: nil,
                preferredStyle: .actionSheet
            )
            actionSheet.addAction(UIAlertAction(title: "로그아웃", style: .destructive) { _ in
                AppDelegate.instance?.GeneralUsersTabBarScreen(selectIndex: 1)
            })
            actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
            self.present(actionSheet, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "섹션 " +  "\(section+1)"
    }
    
}
