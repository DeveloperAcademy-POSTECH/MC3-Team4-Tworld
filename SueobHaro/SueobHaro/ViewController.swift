//
//  ViewController.swift
//  SueobHaro
//
//  Created by leejunmo on 2022/07/16.
//

import UIKit
import SwiftUI

struct TestCellData: Hashable {
    var name: String
}

enum Section: Int, Hashable, CaseIterable {
    case next
    case prev
}

class ViewController: UIViewController {
    
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
            cell.dayOfWeeklabel.text = "화"
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, TestCellData>(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, TestCellData>()
        snapshot.appendSections([.next])
        snapshot.appendItems([
            TestCellData(name: "asdfasdfasdf"),
            TestCellData(name: "asdfasdff"),
            TestCellData(name: "asdfasdfasㅁㅁdf")
        ])
        
        dataSource.apply(snapshot, animatingDifferences: false)
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
