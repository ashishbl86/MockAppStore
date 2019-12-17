//
//  Item.swift
//  MockAppStore
//
//  Created by Ashish Bansal on 09/12/19.
//  Copyright © 2019 Ashish Bansal. All rights reserved.
//

import UIKit

struct Item: Hashable, Decodable {
    
    let id: Int
    let tagline: String
    let name: String
    let subheading: String
    let image: UIImage
    let iap: Bool
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, tagline, name, subheading, image, iap
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        tagline = try container.decode(String.self, forKey: .tagline)
        name = try container.decode(String.self, forKey: .name)
        subheading = try container.decode(String.self, forKey: .subheading)
        let imageName = try container.decode(String.self, forKey: .image)
        image = UIImage(named: imageName)!
        iap = try container.decode(Bool.self, forKey: .iap)
    }
}
