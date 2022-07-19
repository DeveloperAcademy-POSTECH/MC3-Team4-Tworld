//
//  ViewController.swift
//  SueobHaro
//
//  Created by leejunmo on 2022/07/16.
//

import UIKit
import SwiftUI
import CoreData
 
enum Section: Int, Hashable, CaseIterable {
    case next
    case prev
    
    var description: String {
        switch self {
        case .next:
            return "다음 수업을 잊지마세요!"
        case .prev:
            return "지난 수업을 확인해보세요"
        }
    }
}

class ViewController: UIViewController {
    
    static let sectionHeaderElementKind = "section-header-element-kind"
    var dataSource: UICollectionViewDiffableDataSource<Section, Schedule>! = nil

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
        configureCollectionView()
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
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .estimated(34))
            
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: ViewController.sectionHeaderElementKind,
                alignment: .top)
            
            section.boundarySupplementaryItems = [sectionHeader]
            
            return section
        }
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
        return layout
    }
}

extension ViewController: UICollectionViewDelegate {
    func configureCollectionView() {
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: .padding.toComponents),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        let cellRegistration = UICollectionView.CellRegistration<ClassInfoCell, Schedule> { (cell, indexPath, item) in
            cell.titleLabel.text = item.classInfo?.name ?? ""
            cell.durationLabel.text = "\((item.startTime ?? Date()).toString())~\((item.endTime ?? Date()).toString())"
            let members = item.classInfo?.members?.allObjects as? [Members] ?? []
            cell.teamLabel.text = String(members.reduce(into: ""){ $0 += "\($1.name ?? "")" }.dropLast(2))
            cell.progressInfoLabel.text = item.progress ?? ""
            
            var container = AttributeContainer()
            container.font = .systemFont(for: .caption)
            
            cell.progressCountLabel.configuration?.attributedTitle = AttributedString("3회차", attributes: container)
            
            cell.daylabel.text = "18"
            
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration
        <TitleHeaderSupplementaryView>(elementKind: ViewController.sectionHeaderElementKind) {
            (supplementaryView, string, indexPath) in
            supplementaryView.label.text = Section(rawValue: indexPath.section)?.description
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Schedule>(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(
                using: headerRegistration, for: index)
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
    private func configureNavbar() {
        let iconButton = UIButton(type: .custom)
        let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .semibold))!
        iconButton.setImage(image, for: .normal)
        iconButton.imageView?.tintColor = .theme.spLightBlue
        iconButton.setTitle("수업 추가하기", for: .normal)
        iconButton.setTitleColor(.cyan, for: .normal)
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
    @objc private func addSchedule() {
        DataManager.shared.addClassInfo(firstDate: Date(), tuition: 12, tuitionPer: 12, name: "코딩 영재반", color: "blue", location: "집", day: ["월"], startTime: [Date()], endTime: [Date()], memberName: ["예훈"], memberPhoneNumber: ["010-4170-1111"])
        DataManager.shared.fetchData(target: .classInfo)
        if let classInfo = DataManager.shared.classInfo?.first {
            DataManager.shared.addSchedule(count: 1, endTime: Date(), startTime: Date(), isCanceled: false, progress: "asdfasdf", classInfo: classInfo)
        }
        DataManager.shared.fetchData(target: .schedule)
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

extension Date {
    func toString() -> String {
        return self.formatted(date: .omitted, time: .shortened)
    }
}

struct PreView: PreviewProvider {
    static var previews: some View {
        ViewController().toPreview()
            .ignoresSafeArea()
            .preferredColorScheme(.dark)
    }
}

#if DEBUG
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
#endif
