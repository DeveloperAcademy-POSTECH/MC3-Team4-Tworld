//
//  ClassMemberTableViewCell.swift
//  SueobHaro
//
//  Created by Sooik Kim on 2022/08/01.
//

import UIKit
import SwiftUI

class ClassMemberTableViewCell: UITableViewCell {
    
    static let identifier = "ClassMemberTableViewCell"
    
    var sectionClass: ClassInfo?
    var memberArray: [Members]?
    
    private var titles: [String] = [String]()
    var innerNavigationControll: InnerNavigationControll?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 142, height: 97)
        layout.scrollDirection = .horizontal
    
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ClassMemberCollectionViewCell.self, forCellWithReuseIdentifier:  ClassMemberCollectionViewCell.identifier)
        return collectionView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.layer.backgroundColor = UIColor.theme.spBlack.cgColor
        contentView.backgroundColor = .theme.spBlack
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let classData = sectionClass else {return}
        memberArray = DataManager.shared.getMembers(classInfo: classData)
        
        collectionView.frame = CGRect(x: .padding.margin, y: 0, width: contentView.bounds.size.width, height: contentView.bounds.size.height)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension ClassMemberTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClassMemberCollectionViewCell.identifier, for: indexPath) as? ClassMemberCollectionViewCell else {
            return UICollectionViewCell() }
        guard let member = memberArray else { return cell }
        cell.memberValue = member[indexPath.row]
        
        return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print(memberArray?.count ?? 100)
        return memberArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let member = memberArray else { return }
        innerNavigationControll?.selectItem(member: member[indexPath.row])
    }
    
}
