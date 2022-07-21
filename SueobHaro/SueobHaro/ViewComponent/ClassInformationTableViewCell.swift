//
//  ClassInformationTableViewCell.swift
//  SueobHaro
//
//  Created by Sooik Kim on 2022/07/20.
//

import UIKit

class ClassInformationTableViewCell: UITableViewCell {
    
    
    static let identifier = "ClassInformationTableViewCell"
    
    public var className: String?

  
    
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
        
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.layer.frame = CGRect(x: 0, y: 0, width: 358, height: 149)
//        contentView.layer.cornerRadius = 10
//        contentView.layer.borderWidth = 1
//        contentView.layer.borderColor = UIColor.theme.greyscale5.cgColor
//        contentView.backgroundColor = .theme.greyscale7
//        contentView.addSubview(dateLabel)
//        contentView.addSubview(timeLabel)
//        contentView.addSubview(countLabel)
//        contentView.addSubview(dividerView)
//        contentView.addSubview(pencilImage)
//        contentView.addSubview(progressLabel)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        dateLabel.frame.size = dateLabel.sizeThatFits(CGSize(width: dateLabel.frame.width, height: dateLabel.frame.height))
//        timeLabel.frame.size = timeLabel.sizeThatFits(CGSize(width: timeLabel.frame.width, height: timeLabel.frame.height))
//        countLabel.frame.size = countLabel.sizeThatFits(CGSize(width: dateLabel.frame.width, height: dateLabel.frame.height))
//        pencilImage.frame.size = pencilImage.sizeThatFits(CGSize(width: pencilImage.frame.width, height: pencilImage.frame.height))
//        progressLabel.frame.size = progressLabel.sizeThatFits(CGSize(width: progressLabel.frame.width, height: progressLabel.frame.height))
//        applyConstraints()
    }
    
    
    private func applyConstraints() {

//
//        progressLabel.text = className ?? "" == "" ? "수업의 진행 상황을 입력해주세요" : className ?? ""
//        if className ?? "" == "" {
//            progressLabel.textColor = .theme.spLightBlue
//        } else {
//            progressLabel.textColor = .theme.greyscale1
//        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }



    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
