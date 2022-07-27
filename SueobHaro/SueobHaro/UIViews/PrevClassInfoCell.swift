//
//  NextClassInfoCell.swift
//  SueobHaro
//
//  Created by 김예훈 on 2022/07/18.
//

import UIKit

class PrevClassInfoCell: UICollectionViewCell {
    static let identifier = "PrevClassInfoCell"
    
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
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor.theme.spTurkeyBlue.cgColor
        
        return stackView
    }()
        
    lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    lazy var schoolIndicator: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.theme.greyscale1
        view.layer.cornerRadius = 4
        
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 8),
            view.heightAnchor.constraint(equalToConstant: 8),
        ])
        
        return view
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

extension PrevClassInfoCell {
    func configure() {
        let divider = UIView(frame: .zero)
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .darkGray
        [schoolIndicator, titleLabel].forEach{ titleStackView.addArrangedSubview($0) }
        [titleStackView, durationLabel].forEach{ labelStackView.addArrangedSubview($0) }
        [progressIcon, progressInfoLabel].forEach{ progressStackView.addArrangedSubview($0) }
        [labelStackView, divider, progressStackView].forEach{ mainStackView.addArrangedSubview($0) }
        self.addSubview(mainStackView)
        self.addSubview(progressCountLabel)
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            
            progressCountLabel.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -16),
            progressCountLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: .padding.toBox)
        ])
    }
}
