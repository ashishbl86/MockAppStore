//
//  SectionHeaderView.swift
//  MockAppStore
//
//  Created by Ashish Bansal on 14/12/19.
//  Copyright © 2019 Ashish Bansal. All rights reserved.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
    
    static let reuseIdentifier = "SectionHeaderView"
    
    let title = UILabel()
    let subTitle = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        title.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 22, weight: .bold))
        title.textColor = .label
        
        //subTitle.font = UIFont.preferredFont(forTextStyle: .title3)
        subTitle.textColor = .secondaryLabel
        
        let separator = UIView(frame: CGRect.zero)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .separator
        
        let stackView = UIStackView(arrangedSubviews: [separator, title, subTitle])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.setCustomSpacing(10, after: separator)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            
            topAnchor.constraint(equalTo: stackView.topAnchor),
            bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
    }
    
    func configure(with section: Section) {
        title.text = section.title
        subTitle.text = section.subtitle
    }
}
