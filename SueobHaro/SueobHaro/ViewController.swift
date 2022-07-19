//
//  ViewController.swift
//  SueobHaro
//
//  Created by leejunmo on 2022/07/16.
//

import UIKit
import SwiftUI

struct TestCellData: Hashable {
    let id = UUID()
    var name: String
}
 
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
    var dataSource: UICollectionViewDiffableDataSource<Section, TestCellData>! = nil

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
        self.view.backgroundColor = .darkGray
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
            section.interGroupSpacing = 14
            section.contentInsets = NSDirectionalEdgeInsets(top: 17, leading: 0, bottom: 17, trailing: 0)
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .estimated(34))
            
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: ViewController.sectionHeaderElementKind,
                alignment: .top)
            sectionHeader.pinToVisibleBounds = true
            
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
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        let cellRegistration = UICollectionView.CellRegistration<ClassInfoCell, TestCellData> { (cell, indexPath, item) in
            cell.titleLabel.text = "코딩 영재반"
            cell.durationLabel.text = "13:00~15:00"
            cell.teamLabel.text = "사샤, 에반, 린다, 베테브, 엑스"
            cell.progressInfoLabel.text = "어쩌구 저쩌꾸까지 설명하고 진도\n나가야함 담주까지 숙제 있었음"
            cell.progressCountLabel.setTitle("3회차", for: .normal)
            cell.daylabel.text = "19"
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration
        <TitleHeaderSupplementaryView>(elementKind: ViewController.sectionHeaderElementKind) {
            (supplementaryView, string, indexPath) in
            supplementaryView.label.text = Section(rawValue: indexPath.section)?.description
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, TestCellData>(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(
                using: headerRegistration, for: index)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, TestCellData>()
        
        // 샘플 데이터 추가
        snapshot.appendSections([.next])
        snapshot.appendItems([
            TestCellData(name: "asdfasdfasdf"),
            TestCellData(name: "asdfasdff"),
            TestCellData(name: "asdf")
        ])
        snapshot.appendSections([.prev])
        snapshot.appendItems([
            TestCellData(name: "fasdf"),
            TestCellData(name: "asdfasf"),
            TestCellData(name: "asdfasf"),
            TestCellData(name: "asdfasf"),
            TestCellData(name: "asdfasf"),
        ])
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension ViewController {
    private func configureNavbar() {
        let iconButton = UIButton(type: .custom)
        let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .semibold))!
        iconButton.setImage(image, for: .normal)
        iconButton.imageView?.tintColor = .cyan
        iconButton.setTitle("수업 추가하기", for: .normal)
        iconButton.setTitleColor(.cyan, for: .normal)
        iconButton.semanticContentAttribute = .forceRightToLeft
        let leftIconBarItem = UIBarButtonItem(customView: iconButton)
        self.navigationItem.rightBarButtonItem = leftIconBarItem
        
        let logo = UILabel(frame: .zero)
        logo.text = "LOGO"
        logo.textColor = .cyan
        let rightIconBarItem = UIBarButtonItem(customView: logo)
        self.navigationItem.leftBarButtonItem = rightIconBarItem
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
