//
//  ClassMemberSectionHeaderView.swift
//  SueobHaro
//
//  Created by Sooik Kim on 2022/08/01.
//

import UIKit

class ClassMemberSectionHeaderView: UIView {
    
    static let identifier = "ClassMemberSectionHeaderView"
    var color:UIColor = .theme.spLightBlue
    var title: String = ""

    private var circleImage: UIView = {
        let view = UIView(frame: .zero)
//        view.frame.size = CGSize(width: 8, height: 8)
//        view.layer.frame.size = CGSize(width: 8, height: 8)
//        view.layer.backgroundColor = UIColor.theme.spLightBlue.cgColor
        view.layer.cornerRadius = 4
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "대이동학교"
        label.font = .systemFont(for: .body1)
        label.textColor = .theme.greyscale1
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(circleImage)
        addSubview(titleLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        titleLabel.frame.size = titleLabel.sizeThatFits(CGSize(width: titleLabel.frame.width, height: titleLabel.frame.height))
        circleImage.layer.backgroundColor = color.cgColor
        titleLabel.text = title
        applyConstraints()
    }
    
    func applyConstraints() {
        
        circleImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let circleImageConstraints = [
            circleImage.widthAnchor.constraint(equalToConstant: 8),
            circleImage.heightAnchor.constraint(equalToConstant: 8),
            circleImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            circleImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding.margin)
        ]
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: circleImage.trailingAnchor, constant: .padding.toText),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(circleImageConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
    }

}
