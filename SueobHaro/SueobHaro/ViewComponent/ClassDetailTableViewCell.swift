//
//  ClassDetailTableViewCell.swift
//  SueobHaro
//
//  Created by Sooik Kim on 2022/07/19.
//

import UIKit

class ClassDetailTableViewCell: UITableViewCell {
    
    static let identifier = "ClassDetailTableViewCell"
    //스케쥴 상황값을 받아올 예정
    public var className: String?

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2022.7.16 (토)"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "13:00~15:00"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.text = "4회차"
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .center
        label.textColor = .theme.greyscale6
        label.layer.cornerRadius = 16
        label.layer.backgroundColor = UIColor.theme.spLightBlue.cgColor
        label.layer.frame.size.width = 42
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dividerView: UIView = {
        let uiView = UIView(frame: CGRect(x: 0, y: 90, width: 400, height: 1))
//        uiView.translatesAutoresizingMaskIntoConstraints = false
        uiView.backgroundColor = .theme.greyscale5
        
        
        return uiView
    }()
    
    
    private let pencilImage: UIImageView = {
        let uiImage = UIImage(systemName: "highlighter")?.withRenderingMode(.alwaysTemplate)
        let uiImageView = UIImageView(image: uiImage)
        uiImageView.tintColor = .theme.spLightBlue
        uiImageView.sizeThatFits(CGSize(width: 20, height: 18))
        uiImageView.translatesAutoresizingMaskIntoConstraints = false
        return uiImageView
    }()
    
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
        
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.layer.frame = CGRect(x: 0, y: 0, width: 358, height: 149)
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.theme.greyscale5.cgColor
        contentView.backgroundColor = .theme.greyscale7
        contentView.addSubview(dateLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(dividerView)
        contentView.addSubview(pencilImage)
        contentView.addSubview(progressLabel)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dateLabel.frame.size = dateLabel.sizeThatFits(CGSize(width: dateLabel.frame.width, height: dateLabel.frame.height))
        timeLabel.frame.size = timeLabel.sizeThatFits(CGSize(width: timeLabel.frame.width, height: timeLabel.frame.height))
        countLabel.frame.size = countLabel.sizeThatFits(CGSize(width: dateLabel.frame.width, height: dateLabel.frame.height))
        pencilImage.frame.size = pencilImage.sizeThatFits(CGSize(width: pencilImage.frame.width, height: pencilImage.frame.height))
        progressLabel.frame.size = progressLabel.sizeThatFits(CGSize(width: progressLabel.frame.width, height: progressLabel.frame.height))
        applyConstraints()
    }
    
    
    private func applyConstraints() {
        let dateLabelConstraints = [
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 19),
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20)
        ]
        
        let timeLabelConstraints = [
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 19),
            timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 19 + 8 + 19.4)
        ]
        
        let countLabelConstraints = [
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            countLabel.topAnchor.constraint(equalTo: topAnchor, constant: 19),
            countLabel.widthAnchor.constraint(equalToConstant: 42),
            countLabel.heightAnchor.constraint(equalToConstant: 26)
        ]
        
        let pencilImageConstraints = [
            pencilImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 19),
            pencilImage.topAnchor.constraint(equalTo: topAnchor, constant: 108)
        ]
        
        
        let progressLabelConstraints = [
            progressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 53),
            progressLabel.topAnchor.constraint(equalTo: topAnchor, constant: 108)
        ]
        
        NSLayoutConstraint.activate(dateLabelConstraints)
        NSLayoutConstraint.activate(timeLabelConstraints)
        NSLayoutConstraint.activate(countLabelConstraints)
        NSLayoutConstraint.activate(pencilImageConstraints)
        NSLayoutConstraint.activate(progressLabelConstraints)
        //추후 스케쥴 Text 값에 따른 표시방식이 달라짐
        progressLabel.text = className ?? "" == "" ? "수업의 진행 상황을 입력해주세요" : className ?? ""
        if className ?? "" == "" {
            progressLabel.textColor = .theme.spLightBlue
        } else {
            progressLabel.textColor = .theme.greyscale1
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
