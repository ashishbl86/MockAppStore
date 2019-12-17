//
//  FeaturedCell.swift
//  MockAppStore
//
//  Created by Ashish Bansal on 10/12/19.
//  Copyright © 2019 Ashish Bansal. All rights reserved.
//

import UIKit

class FeaturedCell: UICollectionViewCell {
    
    static let reuseIdentifier = "FeaturedCell"
    
    private let tagline = UILabel()
    private let title = UILabel()
    private let subheading = UILabel()
    private let imageView = UIImageView()
    
    required init?(coder: NSCoder) {
        fatalError("Not availalbe to be initialized from coder")
    }
    
    func configure(to item: Item) {
        tagline.text = item.tagline.uppercased()
        title.text = item.name
        subheading.text = item.subheading
        imageView.image = item.image
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let separator = UIView(frame: CGRect.zero)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .separator
        
        tagline.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 12, weight: .bold))
        tagline.textColor = .systemBlue
        
        title.font = UIFont.preferredFont(forTextStyle: .title2)
        title.textColor = .label
        
        subheading.font = UIFont.preferredFont(forTextStyle: .title2)
        subheading.textColor = .secondaryLabel
        
        imageView.layer.cornerRadius = 7.0
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        tagline.setContentHuggingPriority(.defaultHigh, for: .vertical)
        title.setContentHuggingPriority(.defaultHigh, for: .vertical)
        subheading.setContentHuggingPriority(.defaultHigh, for: .vertical)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)

        let stackView = UIStackView(arrangedSubviews: [separator, tagline, title, subheading, imageView])
        stackView.setCustomSpacing(10, after: separator)
        stackView.setCustomSpacing(3, after: tagline)
        stackView.setCustomSpacing(5, after: subheading)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
