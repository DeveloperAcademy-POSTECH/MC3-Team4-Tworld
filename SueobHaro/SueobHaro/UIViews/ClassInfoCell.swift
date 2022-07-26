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
        label.textColor = .theme.greyscale1
        return label
    }()
    
    lazy var durationLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(for: .body1)
        label.numberOfLines = 3
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
    
    lazy var progressCountLabel = GradientCapsuleLabel(frame: .zero)
    
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
        label.font = .systemFont(for: .title3)
        label.textColor = .theme.greyscale1
        return label
    }()
    
    lazy var daySubLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(for: .caption)
        label.text = "내일"
        label.textColor = .theme.greyscale3
        return label
    }()
    
    lazy var dayStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
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

class GradientView: UIView {
    var leadingColor: UIColor = UIColor.tertiarySystemBackground
    var trailingColor: UIColor = UIColor.systemPurple

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    override func layoutSubviews() {
        (layer as! CAGradientLayer).colors = [leadingColor.cgColor, trailingColor.cgColor]
        (layer as! CAGradientLayer).startPoint = .init(x: 0, y: 0.5)
        (layer as! CAGradientLayer).endPoint = .init(x: 1, y: 0.5)
        (layer as! CAGradientLayer).locations = [0.0, 1.0]
    }
}

class GradientCapsuleLabel: UIView {
    
    lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .theme.spBlack
        label.font = .systemFont(for: .caption)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configure() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 12
        let gradient = GradientView(frame: .zero)
        gradient.leadingColor = .theme.spLightGradientLeft
        gradient.trailingColor = .theme.spLightGradientRight
        self.addSubview(gradient)
        gradient.layer.cornerRadius = 12
        gradient.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gradient.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            gradient.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            gradient.topAnchor.constraint(equalTo: self.topAnchor),
            gradient.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        self.addSubview(label)
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -6),
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
        ])
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
        [daySubLabel, daylabel].forEach{ dayStackView.addArrangedSubview($0) }
        self.addSubview(dayStackView)
        self.addSubview(mainStackView)
        self.addSubview(progressCountLabel)
        
        NSLayoutConstraint.activate([
            dayStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            dayStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            dayStackView.widthAnchor.constraint(equalToConstant: 32),
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
