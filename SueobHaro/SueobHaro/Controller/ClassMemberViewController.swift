//
//  ClassMemberViewController.swift
//  SueobHaro
//
//  Created by Sooik Kim on 2022/08/01.
//

import UIKit
import SwiftUI

class ClassMemberViewController: UIViewController, InnerNavigationControll {
    
    var classArray: [ClassInfo] = [ClassInfo]()
    
    func selectItem(member: Members) {
        self.navigationController?.pushViewController(UIHostingController(rootView: PersonalMemberView(member: member)), animated: true)
    }
        
    private let schoolTable: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(ClassMemberTableViewCell.self, forCellReuseIdentifier: ClassMemberTableViewCell.identifier)
        return table
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(schoolTable)
        DataManager.shared.fetchData(target: .classInfo)
        classArray = DataManager.shared.classInfo ?? []
        schoolTable.delegate = self
        schoolTable.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        schoolTable.frame = view.bounds
        for i in classArray {
            print(i.name)
        }
    }


}

extension ClassMemberViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        print(classArray.count)
        return classArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ClassMemberTableViewCell.identifier, for: indexPath) as? ClassMemberTableViewCell else { return UITableViewCell() }
        cell.innerNavigationControll = self
        cell.sectionClass = classArray[indexPath.section]
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 97
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let uiView = ClassMemberSectionHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 24))
        uiView.color = .theme.greyscale1
        uiView.title = classArray[section].name ?? ""
        return uiView
    }
    
    
}


protocol InnerNavigationControll {
    func selectItem(member: Members)
}
