////
////  ClassInformationViewController.swift
////  SueobHaro
////
////  Created by Sooik Kim on 2022/07/19.
////
//
//import UIKit
//
//class ClassInformationViewController: UIViewController {
//    
//    public let classInformationView: UITableView = {
//        let uiTableController = UITableView(frame: .zero)
//        uiTableController.register(ClassInformationTableViewCell.self, forCellReuseIdentifier: ClassInformationTableViewCell.identifier)
//        uiTableController.backgroundColor = .theme.spBlack
//        uiTableController.showsVerticalScrollIndicator = false
//        
//        return uiTableController
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.backgroundColor = .theme.spBlack
//        self.view.addSubview(classInformationView)
//        
//        let headerView = ClassInformationHeaderView(frame: CGRect(x: view.bounds.width * 0.1, y: 0, width: view.bounds.width * 0.9, height: 182))
//        classInformationView.tableHeaderView = headerView
//        // Do any additional setup after loading the view.
//    }
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        classInformationView.frame = CGRect(x: 12, y: 0, width: view.bounds.width - 24, height: view.bounds.height)
//    }
//
//}
//
//
//extension ClassInformationViewController: UITableViewDelegate, UITableViewDataSource {
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 12
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: ClassInformationTableViewCell.identifier, for: indexPath) as? ClassInformationTableViewCell else { return UITableViewCell() }
////        cell.className = className?[indexPath.section] ?? ""
//        cell.backgroundColor = .theme.greyscale1
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 59.61
//    }
//    
//    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
//        return 12
//    }
//    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerVeiw = UIView()
//        headerVeiw.backgroundColor = UIColor.clear
//        return headerVeiw
//    }
//    
////    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        tableView.deselectRow(at: indexPath, animated: true)
////
//////            presentModalController()
////        let vc = ProgressUpdateModalViewController()
//////        if let vc1 = vc.presentationController as? UISheetPresentationController {
//////            vc1.detents = [.large()]
//////        }
//////
////        vc.modalTransitionStyle = .coverVertical
////        vc.modalPresentationStyle = .overFullScreen
////        vc.updateCompletion = {(data, flag) in
////            if (flag) {
////                DispatchQueue.main.async {
////                    tableView.reloadData()
////                }
////            }
////        }
////        self.present(vc, animated: true)
////
////    }
//}
