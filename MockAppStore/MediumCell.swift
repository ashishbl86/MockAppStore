//
//  MediumCell.swift
//  MockAppStore
//
//  Created by Ashish Bansal on 14/12/19.
//  Copyright © 2019 Ashish Bansal. All rights reserved.
//

import UIKit

class MediumCell: UICollectionViewCell {
    
    static let reuseIdentifier = "MediumCell"
    
    private let title = UILabel()
    private let subheading = UILabel()
    private let imageView = UIImageView()
    
    required init?(coder: NSCoder) {
        fatalError("Not availalbe to be initialized from coder")
    }
    
    func configure(to item: Item) {
        title.text = item.name
        subheading.text = item.subheading
        imageView.image = item.image
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        title.text = "Blank"
        subheading.text = "Blank"
        
        title.font = UIFont.preferredFont(forTextStyle: .title3)
        title.textColor = .label
        
        subheading.font = UIFont.preferredFont(forTextStyle: .title3)
        subheading.textColor = .secondaryLabel
        
        imageView.layer.cornerRadius = 7.0
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        let downloadIconView = UIImageView(image: UIImage(systemName: "icloud.and.arrow.down"))
        downloadIconView.translatesAutoresizingMaskIntoConstraints = false
        downloadIconView.contentMode = .scaleAspectFit
        downloadIconView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        let downloadIconContainerView = UIView()
        downloadIconContainerView.translatesAutoresizingMaskIntoConstraints = false
        downloadIconContainerView.addSubview(downloadIconView)
        downloadIconContainerView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        downloadIconContainerView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        let innerVerticalStackView = UIStackView(arrangedSubviews: [title, subheading])
        innerVerticalStackView.axis = .vertical
        innerVerticalStackView.distribution = .fillEqually
        innerVerticalStackView.alignment = .leading
        
        let outerStackView = UIStackView(arrangedSubviews: [imageView, innerVerticalStackView, downloadIconContainerView])
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        outerStackView.axis = .horizontal
        outerStackView.distribution = .fill
        outerStackView.alignment = .top
        outerStackView.spacing = 10
        contentView.addSubview(outerStackView)
        
        NSLayoutConstraint.activate([
            downloadIconContainerView.topAnchor.constraint(equalTo: downloadIconView.topAnchor, constant: -10),
            downloadIconContainerView.bottomAnchor.constraint(equalTo: downloadIconView.bottomAnchor),
            downloadIconContainerView.leadingAnchor.constraint(equalTo: downloadIconView.leadingAnchor),
            downloadIconContainerView.trailingAnchor.constraint(equalTo: downloadIconView.trailingAnchor),
            
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: outerStackView.heightAnchor),
            
            outerStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            outerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            outerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            outerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
