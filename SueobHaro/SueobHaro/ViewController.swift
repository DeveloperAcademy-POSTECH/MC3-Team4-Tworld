//
//  ViewController.swift
//  SueobHaro
//
//  Created by leejunmo on 2022/07/16.
//

import UIKit
import SwiftUI
import CoreData
import Combine

enum Section: Int, Hashable, CaseIterable {
    case next
    case prev
    
    var description: String {
        switch self {
        case .next:
            return "다음일정"
        case .prev:
            return "지난일정"
        }
    }
}

class ViewController: UIViewController {
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Schedule>! = nil
    
    var dayStack: [Date] = []
    
    var cancellables = Set<AnyCancellable>()
    
    lazy var segmentedControl: UnderlineSegmentedControl = {
        let control = UnderlineSegmentedControl(items: Section.allCases.map{$0.description})
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentIndex = 0
        let font = UIFont.systemFont(for: .title3)
        control.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.theme.greyscale3,
            NSAttributedString.Key.font: font
        ], for: .normal)
        control.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.theme.greyscale1,
            NSAttributedString.Key.font: font
        ], for: .selected)
        control.layer.cornerRadius = 0
        return control
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.layer.cornerRadius = 20
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard DataManager.shared.container != nil else { fatalError("This view needs a persistent container.") }
            self.view.backgroundColor = .theme.spBlack
            configureNavbar()
            configureSegmentControl()
            configureCollectionView()
            
            DataManager.shared.$schedule.sink { [weak self] schedules in
                if let schedules = schedules {
                    var snapshot = NSDiffableDataSourceSnapshot<Section, Schedule>()
                    
                    var prevSchedules: [Schedule] = []
                    var nextSchedules: [Schedule] = []
                    
                    for schedule in schedules {
                        if (schedule.endTime ?? Date()) < Date() {
                            prevSchedules.append(schedule)
                        } else {
                            nextSchedules.append(schedule)
                        }
                    }
                    
                    if !nextSchedules.isEmpty {
                        snapshot.appendSections([.next])
                        snapshot.appendItems(nextSchedules)
                    }
                    
                    if !prevSchedules.isEmpty {
                        snapshot.appendSections([.prev])
                        snapshot.appendItems(prevSchedules)
                    }
                    
                    self?.dataSource.apply(snapshot, animatingDifferences: false)
                }
            }
            .store(in: &cancellables)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let section: NSCollectionLayoutSection
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = .padding.toComponents
            section.contentInsets = NSDirectionalEdgeInsets(top: .padding.toTextComponents, leading: 0, bottom: .padding.toDifferentHierarchy, trailing: 0)
            
            return section
        }
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
        return layout
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(UIHostingController(rootView: ClassDetailView()), animated: true)
    }
    
    func configureCollectionView() {
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.segmentedControl.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        let cellRegistration = UICollectionView.CellRegistration<ClassInfoCell, Schedule> { (cell, indexPath, item) in
            cell.titleLabel.text = item.classInfo?.name ?? ""
            cell.durationLabel.text = "\((item.startTime ?? Date()).toString())~\((item.endTime ?? Date()).toString())"
            let members = item.classInfo?.members?.allObjects as? [Members] ?? []
            cell.teamLabel.text = String(members.reduce(into: ""){ $0 += "\($1.name ?? ""), " }.dropLast(2))
            cell.progressInfoLabel.text = item.progress ?? ""
            
            var container = AttributeContainer()
            container.font = .systemFont(for: .caption)
            cell.progressCountLabel.label.text = "\(item.count)회차"
            
            cell.daylabel.text = item.startTime?.todayString() ?? ""
            cell.daySubLabel.text = item.startTime?.toDayOfWeekString() ?? ""
            
            if indexPath.row > 0, Calendar.current.isDate((DataManager.shared.schedule?[indexPath.row - 1].startTime ?? Date()), inSameDayAs: item.startTime ?? Date()) {
                cell.dayStackView.alpha = 0
            }
        }
        
        
        dataSource = UICollectionViewDiffableDataSource<Section, Schedule>(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Schedule>()
        
        // 샘플 데이터 추가
        snapshot.appendSections([.next])
        DataManager.shared.fetchData(target: .schedule)
        snapshot.appendItems(
            DataManager.shared.schedule ?? []
        )
        snapshot.appendSections([.prev])
        snapshot.appendItems([
        ])
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension ViewController {
    
    private func configureSegmentControl() {
        view.addSubview(segmentedControl)
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            segmentedControl.widthAnchor.constraint(equalToConstant: 180),
            segmentedControl.heightAnchor.constraint(equalToConstant: 40)
        ])
        segmentedControl.addTarget(self, action: #selector(changeSection(segment:)), for: .valueChanged)
    }
    
    private func configureNavbar() {
        let iconButton = UIButton(type: .custom)
        let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .semibold))!
        iconButton.setImage(image, for: .normal)
        iconButton.imageView?.tintColor = .theme.spLightBlue
        iconButton.setTitle("수업 추가하기", for: .normal)
        iconButton.setTitleColor(.theme.spLightBlue, for: .normal)
        iconButton.semanticContentAttribute = .forceRightToLeft
        iconButton.addTarget(self, action: #selector(addSchedule), for: .touchUpInside)
        let leftIconBarItem = UIBarButtonItem(customView: iconButton)
        self.navigationItem.rightBarButtonItem = leftIconBarItem
        
        let logo = UILabel(frame: .zero)
        logo.text = "LOGO"
        logo.textColor = .theme.spLightBlue
        let rightIconBarItem = UIBarButtonItem(customView: logo)
        self.navigationItem.leftBarButtonItem = rightIconBarItem
    }
}

extension ViewController {
    
    private func addGradient(uiView: UIView) {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.theme.spBlack.cgColor, UIColor.theme.spLightGradientRight.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = uiView.bounds
        uiView.layer.addSublayer(gradient)
    }
    
    @objc private func changeSection(segment: UISegmentedControl) {
        
    }
    
    @objc private func addSchedule() {
        self.navigationController?.pushViewController(UIHostingController(rootView: ClassNameView(dismissAction: {
            self.navigationController?.popToViewController(self, animated: true)
            DataManager.shared.fetchData(target: .schedule)
        })), animated: true)
    }
}

extension Date {
    func toString() -> String {
        return self.formatted(date: .omitted, time: .shortened)
    }
    
    func todayString() -> String {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date)
        let dayOfMonth = components.day
        return String(dayOfMonth ?? 0)
    }
    
    func toDayOfWeekString() -> String {
        let calendar = Calendar.current
        if calendar.isDateInToday(self) {
            return "오늘"
        } else if calendar.isDateInTomorrow(self) {
            return "내일"
        } else {
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            let dayOfTheWeekString = dateFormatter.string(from: date)
            return dayOfTheWeekString
        }
        
    }
}

struct PreView: PreviewProvider {
    static var previews: some View {
        ViewController().toPreview()
            .ignoresSafeArea()
            .preferredColorScheme(.dark)
    }
}

extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }
    
    func toPreview() -> some View {
        Preview(viewController: self)
    }
}

