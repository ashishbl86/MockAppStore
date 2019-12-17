//
//  ItemSupplementaryView.swift
//  MockAppStore
//
//  Created by Ashish Bansal on 14/12/19.
//  Copyright © 2019 Ashish Bansal. All rights reserved.
//

import UIKit

class ItemTrailingView: UICollectionReusableView {

    static let reuseIdentififer = "ItemTrailingView"
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let separator = UIView(frame: CGRect.zero)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .separator
        
        addSubview(separator)
        
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: topAnchor),
            separator.bottomAnchor.constraint(equalTo: bottomAnchor),
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
