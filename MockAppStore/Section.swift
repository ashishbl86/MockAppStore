//
//  Section.swift
//  MockAppStore
//
//  Created by Ashish Bansal on 09/12/19.
//  Copyright © 2019 Ashish Bansal. All rights reserved.
//

import Foundation

enum SectionType: String {
    case featured, mediumTable, smallTable
}
 
struct Section: Hashable, Decodable {
    
    let id: Int
    let type: SectionType
    let title: String
    let subtitle: String
    let items: [Item]

    static func == (lhs: Section, rhs: Section) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, type, title, subtitle, items
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        let sectionTypeLiteral = try container.decode(String.self, forKey: .type)
        type = SectionType(rawValue: sectionTypeLiteral)!
        title = try container.decode(String.self, forKey: .title)
        subtitle = try container.decode(String.self, forKey: .subtitle)
        items = try container.decode(Array<Item>.self, forKey: .items)
    }
}
