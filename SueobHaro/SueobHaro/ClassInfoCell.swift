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
        label.font = .systemFont(for: .title3)
        return label
    }()
    
    lazy var durationLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(for: .body1)
        label.textColor = .theme.greyscale3
        return label
    }()
    
    lazy var teamLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(for: .body1)
        label.textColor = .theme.greyscale3
        return label
    }()
    
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = .padding.toText
        return stackView
    }()
    
    lazy var progressCountLabel: UIButton = {
        
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.baseForegroundColor = .black
        configuration.baseBackgroundColor = .theme.spLightBlue
        configuration.buttonSize = .medium
        
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var progressIcon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        let image = UIImage(systemName: "highlighter", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .semibold))!
        imageView.tintColor = .theme.spLightBlue
        imageView.image = image
        return imageView
    }()
    
    lazy var progressInfoLabel: ProgressLabel = {
        let label = ProgressLabel(frame: .zero)
        label.font = .systemFont(for: .body2)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var progressStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = 14
        return stackView
        
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = .padding.inBox
        stackView.backgroundColor = .black
        stackView.layoutMargins = UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layer.cornerRadius = 12
        stackView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor.theme.spLightBlue.cgColor
        return stackView
    }()
    
    lazy var daylabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "asdfasdfas"
        label.font = .systemFont(for: .title3)
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

class ProgressLabel: UILabel {
    
    let placeHolder = "진행한 진도를 입력해주세요."
    
    override var text: String? {
        didSet {
            if let text = text {
                if text == "" {
                    self.text = placeHolder
                    self.textColor = .cyan
                } else {
                    self.textColor = .white
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension ClassInfoCell {
    func configure() {
        let divider = UIView(frame: .zero)
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .darkGray
        
        [titleLabel, durationLabel, teamLabel].forEach{ labelStackView.addArrangedSubview($0) }
        [progressIcon, progressInfoLabel].forEach{ progressStackView.addArrangedSubview($0) }
        [labelStackView, divider, progressStackView].forEach{ mainStackView.addArrangedSubview($0) }
        
        self.addSubview(daylabel)
        self.addSubview(mainStackView)
        self.addSubview(progressCountLabel)
        
        NSLayoutConstraint.activate([
            daylabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17),
            daylabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            mainStackView.leadingAnchor.constraint(equalTo: daylabel.trailingAnchor, constant: .padding.toComponents),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 1),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            
            progressCountLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -17),
            progressCountLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: .padding.toBox)
        ])
    }
}
