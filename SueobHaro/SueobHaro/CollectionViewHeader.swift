//
//  TitleHeaderSupplementaryView.swift
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

extension TitleHeaderSupplementaryView {
    func configure() {
        [label].forEach{ addSubview($0) }
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
