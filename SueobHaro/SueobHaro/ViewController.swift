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

enum Section: Int, Hashable, CaseIterable, CustomStringConvertible {
    case next
    case prev
    
    var description: String {
        switch self {
        case .next:
            return "다음일정"
        case .prev:
            return "빠른노트"
        }
    }
}

class ViewController: UIViewController {
    
    static let sectionHeaderElementKind = "titleHeader-supplementary-reuse-identifier"
    private var dataSource: UICollectionViewDiffableDataSource<Section, Schedule>? = nil
    private var dayStack: [Date] = []
    private var nowSection: Section = .next {
        didSet {
            updateCell()
        }
    }
    
    var schedules: [Schedule] = []
    
    lazy var segmentedControl: UnderlineSegmentedControl = {
        let control = UnderlineSegmentedControl(items: Section.allCases.map{$0.description})
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentIndex = 0
        self.changeSection(segment: control)
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
    
    lazy var noCellLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "등록된 수업이 없어요!"
        label.font = .systemFont(for: .title3)
        label.textColor = .theme.greyscale1
        label.alpha = 0.5
        return label
    }()
    
    lazy var noCellView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 26
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "question")
        let icon = UIImageView(image: image)
        [icon, noCellLabel].forEach{ stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("수업 추가하러 가기", for: .normal)
        button.setTitleColor(UIColor.theme.greyscale1, for: .normal)
        button.titleLabel?.font = .systemFont(for: .button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.layer.cornerRadius = 12
        let gradient = GradientView(frame: .zero)
        gradient.leadingColor = .theme.spDeepGradientLeft
        gradient.trailingColor = .theme.spDeepGradientRight
        gradient.isUserInteractionEnabled = false
        button.insertSubview(gradient, at: 0)
        gradient.layer.cornerRadius = 12
        gradient.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gradient.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            gradient.trailingAnchor.constraint(equalTo: button.trailingAnchor),
            gradient.topAnchor.constraint(equalTo: button.topAnchor),
            gradient.bottomAnchor.constraint(equalTo: button.bottomAnchor),
        ])
        
        button.addTarget(self, action: #selector(addSchedule), for: .touchUpInside)
        
        return button
    }()
    
    lazy var indicator: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4
        view.backgroundColor = .theme.spLightBlue
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        guard DataManager.shared.container != nil else { fatalError("This view needs a persistent container.") }
            self.view.backgroundColor = .theme.spBlack
//            configureNavbar()
            configureSegmentControl()
            configureCollectionView()
            configureIndicator()
            configureNoCellView()
            updateCell()
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
                                                    heightDimension: .estimated(60))
            
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: ViewController.sectionHeaderElementKind,
                alignment: .top)
            
            if self.nowSection == .prev {
                section.boundarySupplementaryItems = [sectionHeader]
            }
            
            return section
        }
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
        return layout
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if nowSection == .next {
            print(schedules[indexPath.row])
            self.navigationController?.pushViewController(UIHostingController(rootView: ClassDetailView(selectedClass: schedules[indexPath.row].classInfo, dismissAction: {
                self.collectionView.reloadData()
            })), animated: true)
        } else {
            self.navigationController?.pushViewController(UIHostingController(rootView: ClassDetailView(selectedClass: schedules[indexPath.row].classInfo, selectedSchedule: schedules[indexPath.row], dismissAction: {
                self.updateCell()
                self.collectionView.reloadData()
            })), animated: true)
        }
        
    }
    
    func configureCollectionView() {
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.segmentedControl.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        let nextCellRegistration = UICollectionView.CellRegistration<NextScheduleInfoCell, Schedule> { (cell, indexPath, item) in
            cell.titleLabel.text = item.classInfo?.name ?? ""
            cell.durationLabel.text = DateFormatUtil.scheduleDateFormatter(item.startTime ?? Date(), item.endTime ?? Date())
            let members = item.classInfo?.members?.allObjects as? [Members] ?? []
            cell.teamLabel.text = String(members.reduce(into: ""){ $0 += "\($1.name ?? ""), " }.dropLast(2))
            cell.progressInfoLabel.text = item.preSchedule?.progress ?? ""
            
            var container = AttributeContainer()
            container.font = .systemFont(for: .caption)
            cell.progressCountLabel.label.text = "\(item.count)회차"
            
            cell.daylabel.text = item.startTime?.todayString() ?? ""
            cell.daySubLabel.text = item.startTime?.toDayOfWeekString() ?? ""
            
            cell.schoolIndicator.backgroundColor = UIColor(named: item.classInfo?.color ?? "randomBlue")
            
            if indexPath.row > 0, Calendar.current.isDate((DataManager.shared.schedule?[indexPath.row - 1].startTime ?? Date()), inSameDayAs: item.startTime ?? Date()) {
                cell.dayStackView.alpha = 0
            }
        }
        
        let prevCellRegistration = UICollectionView.CellRegistration<PrevScheduleInfoCell, Schedule> { (cell, indexPath, item) in
            cell.titleLabel.text = item.classInfo?.name ?? ""
            let dateString = item.startTime?.formatted(date: .complete, time: .omitted) ?? ""
            let timeString = DateFormatUtil.scheduleDateFormatter(item.startTime ?? Date(), item.endTime ?? Date())
            cell.durationLabel.text = dateString + "  " + timeString
            let members = item.classInfo?.members?.allObjects as? [Members] ?? []
            cell.teamLabel.text = String(members.reduce(into: ""){ $0 += "\($1.name ?? ""), " }.dropLast(2))
            cell.schoolIndicator.backgroundColor = UIColor(named: item.classInfo?.color ?? "")
            
            var container = AttributeContainer()
            container.font = .systemFont(for: .caption)
            cell.progressCountLabel.label.text = "\(item.count)회차"
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration
        <TitleHeaderSupplementaryView>(elementKind: ViewController.sectionHeaderElementKind) {
            (supplementaryView, string, indexPath) in
        }
                
        dataSource = UICollectionViewDiffableDataSource<Section, Schedule>(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch self.nowSection {
            case .next:
                return collectionView.dequeueConfiguredReusableCell(using: nextCellRegistration, for: indexPath, item: item)
            case .prev:
                return collectionView.dequeueConfiguredReusableCell(using: prevCellRegistration, for: indexPath, item: item)
            }
        }
        
        dataSource?.supplementaryViewProvider = { (view, kind, index) in
            if kind == ViewController.sectionHeaderElementKind {
                return self.collectionView.dequeueConfiguredReusableSupplementary(
                using: headerRegistration, for: index)
            }
            return nil
        }
    }
}

extension ViewController {
    
    private func configureNoCellView() {
        view.addSubview(noCellView)
        view.addSubview(addButton)
        NSLayoutConstraint.activate([
            noCellView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            noCellView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            addButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            addButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            addButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
    
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
    
    private func configureIndicator() {
        view.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.topAnchor.constraint(equalTo: segmentedControl.topAnchor, constant: 8),
            indicator.trailingAnchor.constraint(equalTo: segmentedControl.trailingAnchor),
            indicator.widthAnchor.constraint(equalToConstant: 8),
            indicator.heightAnchor.constraint(equalToConstant: 8),
        ])
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
    
    private func updateCell() {
        DataManager.shared.fetchData(target: .schedule)
        self.schedules = DataManager.shared.fetchSchedules(section: nowSection)
        var snapshot = NSDiffableDataSourceSnapshot<Section, Schedule>()
        if !schedules.isEmpty {
            snapshot.appendSections([nowSection])
            snapshot.appendItems(schedules)
        }
        if let dataSource = self.dataSource {
            dataSource.apply(snapshot, animatingDifferences: false)
        }
        if schedules.isEmpty {
            noCellLabel.text = nowSection == .next ? "등록된 수업이 없어요!" : "노트를 작성하지 않은 수업이 없어요!"
            noCellView.alpha = 1
            addButton.alpha = 1
        } else {
            noCellView.alpha = 0
            addButton.alpha = 0
        }
    }
    
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
        self.nowSection = segment.selectedSegmentIndex == 0 ? .next : .prev
    }
    
    @objc private func addSchedule() {
        let controller = UIHostingController(rootView: ClassAddView(dismissAction: {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            self.navigationController?.popToViewController(self, animated: true)
            self.updateCell()
        }))
        controller.hidesBottomBarWhenPushed = true

        self.navigationController?.pushViewController((controller), animated: true)
    }
}

// 셀 적용 테스트 위한 코드. 차후 셀 하이파이 확정되면 기존 DateFormatter 코드로 바꿀 예정
extension Date {
    func toString() -> String {
        return self.formatted(date: .complete, time: .shortened)
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

