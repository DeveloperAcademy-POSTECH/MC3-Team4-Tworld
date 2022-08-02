//
//  NextClassInfoCell.swift
//  SueobHaro
//
//  Created by 김예훈 on 2022/07/18.
//

import UIKit

class PrevScheduleInfoCell: UICollectionViewCell {
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

extension PrevScheduleInfoCell {
    func configure() {
        [schoolIndicator, titleLabel].forEach{ titleStackView.addArrangedSubview($0) }
        [titleStackView, durationLabel, teamLabel].forEach{ labelStackView.addArrangedSubview($0) }
        [labelStackView].forEach{ mainStackView.addArrangedSubview($0) }
        self.addSubview(mainStackView)
        self.addSubview(progressCountLabel)
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
            progressCountLabel.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -16),
            progressCountLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: .padding.toBox)
        ])
    }
}
