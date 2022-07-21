//
//  ClassInformationHeaderView.swift
//  SueobHaro
//
//  Created by Sooik Kim on 2022/07/20.
//

import UIKit

class ClassInformationHeaderView: UIView {
    

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Genius Coding"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(for: .title2)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "X, Rinda, Sasha, Bethev, Evan"
        label.textColor = .gray
        label.font = .systemFont(for: .body1)
        return label
    } ()
    
    private let dividerView: UIView = {
        let uiView = UIView(frame: CGRect(x: 0, y: 90, width: 400, height: 1))
//        uiView.translatesAutoresizingMaskIntoConstraints = false
        uiView.backgroundColor = .theme.greyscale5
        
        
        return uiView
    }()
    
    private let firstDateLabel: UILabel = {
        let label = UILabel()
        label.text = "2022.03.20 부터 수업을 진행했어요"
        label.textColor = .theme.greyscale1
        label.font = .systemFont(for: .body2)
        return label
    } ()
    
    private let tutionLabel: UILabel = {
        let label = UILabel()
        label.text = "4회마다 총 300,000원 받아요"
        label.textColor = .theme.greyscale1
        label.font = .systemFont(for: .title3)
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
        addSubview(dividerView)
        addSubview(firstDateLabel)
        addSubview(tutionLabel)
        
        applyConstraints()
    
    }
    
    override func layoutSubviews() {
        let width = frame.width
//        let height = frame.height
        super.layoutSubviews()
        let titleLabelSize = titleLabel.sizeThatFits(CGSize(width: titleLabel.frame.width, height: titleLabel.frame.height))
        titleLabel.frame = CGRect(x: width/2 - titleLabelSize.width/2, y: 18, width: titleLabelSize.width, height: titleLabelSize.height)
        let newSize = nameLabel.sizeThatFits(CGSize(width: nameLabel.frame.width, height: nameLabel.frame.height))
        nameLabel.frame.size.width = newSize.width
        nameLabel.frame.size.height = newSize.height
        nameLabel.frame.origin.x = width/2 - newSize.width/2
        nameLabel.frame.origin.y = 18 + titleLabel.frame.size.height + 8
        
        let dateLabel = firstDateLabel.sizeThatFits(CGSize(width: firstDateLabel.frame.width, height: firstDateLabel.frame.height))
        firstDateLabel.frame.size = dateLabel
        firstDateLabel.frame.origin.x = width/2 - dateLabel.width/2
        firstDateLabel.frame.origin.y = 18 + newSize.height + 8 + titleLabel.frame.size.height + 18 + 18
        
        let tutionLabelSize = tutionLabel.sizeThatFits(CGSize(width: tutionLabel.frame.width, height: tutionLabel.frame.height))
        tutionLabel.frame.size = tutionLabelSize
        tutionLabel.frame.origin.x = width/2 - tutionLabelSize.width/2
        tutionLabel.frame.origin.y = firstDateLabel.frame.origin.y + firstDateLabel.frame.size.height + 8

    }
    
    
    
    private func applyConstraints() {

    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
