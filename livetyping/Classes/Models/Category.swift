//
//  Category.swift
//  livetyping
//
//  Created by Павел Пособило on 05.12.2019.
//  Copyright © 2019 Павел Пособило. All rights reserved.
//

import Foundation

struct Category: Codable, Equatable, Hashable {
    
    // MARK: Properties
    
    var strCategory: String
    
    // MARK: Initialization
    
    enum CodingKeys: String, CodingKey {
        case strCategory
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.strCategory = try! container.decode(String.self, forKey: .strCategory)
    }
    
}
