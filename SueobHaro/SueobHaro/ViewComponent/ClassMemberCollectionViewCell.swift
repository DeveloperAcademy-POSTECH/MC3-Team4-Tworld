//
//  ClassMemberCollectionViewCell.swift
//  SueobHaro
//
//  Created by Sooik Kim on 2022/08/01.
//

import UIKit

class ClassMemberCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ClassMemberCollectionViewCell"
    
    var memberValue: Members?
    
    private let memberNameLabel: UILabel = {
        let label = UILabel()
        label.text = "사샤"
        label.font = .systemFont(for: .title3)
        label.textColor = .theme.greyscale1
        return label
    }()
    
    private let memberSchoolLabel: UILabel = {
        let label = UILabel()
        label.text = "태장초등학교"
        label.font = .systemFont(for: .caption)
        label.textColor = .theme.greyscale3
        return label
    }()
    
    private let memberPhoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "010-2014-4586"
        label.font = .systemFont(for: .caption)
        label.textColor = .theme.greyscale3
        return label
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.theme.spLightBlue.cgColor
        contentView.backgroundColor = .theme.greyscale7
        contentView.addSubview(memberNameLabel)
        contentView.addSubview(memberSchoolLabel)
        contentView.addSubview(memberPhoneNumberLabel)
        
        
    }
    
    override func layoutSubviews() {
        memberNameLabel.frame.size = memberNameLabel.sizeThatFits(CGSize(width: memberNameLabel.frame.width, height: memberNameLabel.frame.height))
        memberSchoolLabel.frame.size = memberSchoolLabel.sizeThatFits(CGSize(width: memberSchoolLabel.frame.width, height: memberSchoolLabel.frame.height))
        memberPhoneNumberLabel.frame.size = memberPhoneNumberLabel.sizeThatFits(CGSize(width: memberPhoneNumberLabel.frame.width, height: memberPhoneNumberLabel.frame.height))
        memberNameLabel.text = memberValue?.name ?? "NoName"
        memberSchoolLabel.text = memberValue?.school?.name ?? "NoSchool"
        memberPhoneNumberLabel.text = memberValue?.phoneNumber ?? "NoPhone"
        applyConstraints()
    }
    
    private func applyConstraints() {
        memberNameLabel.translatesAutoresizingMaskIntoConstraints = false
        memberSchoolLabel.translatesAutoresizingMaskIntoConstraints = false
        memberPhoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        let memberNameLabelConstraints = [
            memberNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding.inBox),
            memberNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: .padding.inBox),
        ]
        
        let memberSchoolLabelConstraints = [
            memberSchoolLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding.inBox),
            memberSchoolLabel.topAnchor.constraint(equalTo: memberNameLabel.bottomAnchor, constant: .padding.toText),
        ]
        
        let memberPhoneNumberConstraints = [
            memberPhoneNumberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding.inBox),
            memberPhoneNumberLabel.topAnchor.constraint(equalTo: memberSchoolLabel.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(memberNameLabelConstraints)
        NSLayoutConstraint.activate(memberSchoolLabelConstraints)
        NSLayoutConstraint.activate(memberPhoneNumberConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
