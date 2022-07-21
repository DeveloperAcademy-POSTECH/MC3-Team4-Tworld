//
//  ClassDetailHeaderView.swift
//  SueobHaro
//
//  Created by Sooik Kim on 2022/07/18.
//

import UIKit

class ClassDetailHeaderView: UIView {
    
    let tapGestureRecognizer = UITapGestureRecognizer()
    

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Genius Coding"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "X, Rinda, Sasha, Bethev, Evan"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .theme.greyscale7
        self.layer.borderColor = UIColor.theme.spLightBlue.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        addSubview(titleLabel)
        addSubview(nameLabel)
        addGestureRecognizer(tapGestureRecognizer)
        
    
    }
    
    override func layoutSubviews() {
        let width = frame.width
        super.layoutSubviews()
        let titleLabelSize = titleLabel.sizeThatFits(CGSize(width: titleLabel.frame.width, height: titleLabel.frame.height))
        titleLabel.frame = CGRect(x: width/2 - titleLabelSize.width/2, y: CGFloat.padding.inBox, width: titleLabelSize.width, height: titleLabelSize.height)
        let newSize = nameLabel.sizeThatFits(CGSize(width: nameLabel.frame.width, height: nameLabel.frame.height))
        nameLabel.frame.size.width = newSize.width
        nameLabel.frame.size.height = newSize.height
        nameLabel.frame.origin.x = width/2 - newSize.width/2
        nameLabel.frame.origin.y = titleLabel.frame.origin.y + titleLabel.frame.size.height + CGFloat.padding.toText

    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    

}
