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
    
    lazy var progressCountLabel: UIButton = {
        
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.baseForegroundColor = .black
        configuration.baseBackgroundColor = .cyan
        configuration.buttonSize = .medium
        
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var progressIcon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        let image = UIImage(systemName: "highlighter", withConfiguration: UIImage.SymbolConfiguration(pointSize: 13, weight: .semibold))!
        imageView.image = image
        return imageView
    }()
    
    lazy var progressInfoLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var progressStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.alignment = .top
        return stackView
        
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 18
        stackView.backgroundColor = .black
        stackView.layoutMargins = UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layer.cornerRadius = 12
        stackView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor.cyan.cgColor
        return stackView
    }()
    
    lazy var daylabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "asdfasdfas"
        return label
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
        let divider = UIView(frame: .zero)
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.heightAnchor.constraint(equalToConstant: 2).isActive = true
        divider.backgroundColor = .white
        
        [titleLabel, durationLabel, teamLabel].forEach{ labelStackView.addArrangedSubview($0) }
        [progressIcon, progressInfoLabel].forEach{ progressStackView.addArrangedSubview($0) }
        [labelStackView, divider, progressStackView].forEach{ mainStackView.addArrangedSubview($0) }
//        [daylabel, mainStackView].forEach{ cellStackView.addArrangedSubview($0) }
        self.addSubview(daylabel)
        self.addSubview(mainStackView)
        self.addSubview(progressCountLabel)
        
        NSLayoutConstraint.activate([
            daylabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17),
            daylabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            mainStackView.leadingAnchor.constraint(equalTo: daylabel.trailingAnchor, constant: 12),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
            progressCountLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            progressCountLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20)
        ])
    }
}
