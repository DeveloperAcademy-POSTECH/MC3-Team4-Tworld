////
////  ClassDeatilViewController.swift
////  SueobHaro
////
////  Created by Sooik Kim on 2022/07/19.
////
//
//import UIKit
//
//class ClassDeatilViewController: UIViewController {
//
//    public var className: [String]? = ["", "bbb", "ccc", "ddd", "eee", "fff", "ggg"]
//
//
//    public let classDetailView: UITableView = {
//        let uiTableController = UITableView(frame: .zero)
//        uiTableController.register(ClassDetailTableViewCell.self, forCellReuseIdentifier: ClassDetailTableViewCell.identifier)
//        uiTableController.backgroundColor = .theme.spBlack
//        uiTableController.showsVerticalScrollIndicator = false
//        return uiTableController
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
////        view.addSubview(classDetailView)
//        self.view.backgroundColor = .theme.spBlack
//        self.navigationController?.navigationBar.tintColor = .theme.spLightBlue
//        self.view.addSubview(classDetailView)
//
//        classDetailView.delegate = self
//        classDetailView.dataSource = self
//
//        //헤더 뷰 높이 변화 있을 예정 // 타이틀
//        let headerView = ClassDetailHeaderView(frame: CGRect(x: view.bounds.width * 0.1, y: 0, width: view.bounds.width * 0.9, height: 92))
//        headerView.tapGestureRecognizer.addTarget(self, action: #selector(tapToInformation))
//        classDetailView.tableHeaderView = headerView
//
//
//    }
//
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        classDetailView.frame = CGRect(x: 12, y: 0, width: view.bounds.width - 24, height: view.bounds.height)
////        classDetailView.frame = classDetailView.frame.offsetBy(dx: view.bounds.width * 0.025, dy: 50)
////        classDetailView.translatesAutoresizingMaskIntoConstraints = false
//
//    }
//    private func applyConstraints() {
//        let safeArea = view.safeAreaLayoutGuide
//        NSLayoutConstraint.activate([
//            classDetailView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
//        ])
//    }
//
//    @objc func tapToInformation() {
//        self.navigationController?.pushViewController(ClassInformationViewController(), animated: true)
//    }
//
//}
//
//
//
//
//extension ClassDeatilViewController: UITableViewDelegate, UITableViewDataSource {
//
//    // 스케쥴 카운트로 섹션의 갯수를 할당
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return className?.count ?? 0
//    }
//    // 각 섹션 별 행은 1
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    // 카드 뷰 할당
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: ClassDetailTableViewCell.identifier, for: indexPath) as? ClassDetailTableViewCell else { return UITableViewCell() }
//        cell.className = className?[indexPath.section] ?? ""
//        cell.backgroundColor = .theme.spBlack
//        return cell
//    }
//    //각 카드 섹션 높이
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 149
//    }
//    //각 섹션의 헤더 높이(컴퍼넌트 간격)
//    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
//        return CGFloat.padding.toComponents
//    }
//    // 헤더 뷰
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerVeiw = UIView()
//        headerVeiw.backgroundColor = UIColor.clear
//        return headerVeiw
//    }
//    //카드 클릭 시 모달 불러오기
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: false)
//        let vc = ProgressUpdateModalViewController()
//        vc.value = className?[indexPath.section] ?? ""
////        vc.modalTransitionStyle = .coverVertical
//        vc.modalPresentationStyle = .overFullScreen
//        vc.updateCompletion = {(data, flag) in
//            if (flag) {
//                self.className?[indexPath.section] = data
//                DispatchQueue.main.async {
//                    tableView.reloadData()
//                }
//            }
//        }
//        self.present(vc, animated: false)
//
//    }
//
//}
