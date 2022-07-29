//
//  CollectionViewHeader.swift
//  SueobHaro
//
//  Created by 김예훈 on 2022/07/19.
//

import UIKit

class TitleHeaderSupplementaryView: UICollectionReusableView {
    static let reuseIdentifier = "titleHeader-supplementary-reuse-identifier"
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(for: .body1)
        label.textColor = .theme.greyscale1
        label.numberOfLines = 2
        label.textAlignment = .left
        label.text = "완료한 수업을 선택해,\n진도나 특이사항을 수업노트에 적어보세요!"
        return label
    }()
    
    lazy var iconLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(for: .body1)
        label.text = "👀"
        label.textAlignment = .right
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 22
        stackView.backgroundColor = .theme.greyscale6
        stackView.layoutMargins = UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layer.cornerRadius = 10
        
        return stackView
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension TitleHeaderSupplementaryView {
    func configure() {
        [label, iconLabel].forEach{ stackView.addArrangedSubview($0) }
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
        ])
    }
}
