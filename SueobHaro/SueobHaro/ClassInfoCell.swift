//
//  ClassInfoCell.swift
//  SueobHaro
//
//  Created by 김예훈 on 2022/07/18.
//

import UIKit

class ClassInfoCell: UICollectionViewCell {
    static let identifier = "ClassInfoCell"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    lazy var durationLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    lazy var teamLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var progressCountLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    lazy var progressIcon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        let image = UIImage(systemName: "highlighter", withConfiguration: UIImage.SymbolConfiguration(pointSize: 13, weight: .semibold))!
        imageView.image = image
        return imageView
    }()
    
    lazy var progressInfoLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    lazy var progressStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.alignment = .top
        return stackView

    }()
    
    lazy var cellStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.alignment = .leading
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

extension ClassInfoCell {
    func configure() {
        [titleLabel, durationLabel, teamLabel].forEach{ labelStackView.addArrangedSubview($0) }
        [progressIcon, progressInfoLabel].forEach{ progressStackView.addArrangedSubview($0) }
        [labelStackView, progressStackView].forEach{ cellStackView.addArrangedSubview($0) }
        self.contentView.addSubview(cellStackView)
        
        NSLayoutConstraint.activate([
            cellStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            cellStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            cellStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            cellStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
}
