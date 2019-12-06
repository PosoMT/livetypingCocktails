//
//  CocktailDBList.swift
//  livetyping
//
//  Created by Павел Пособило on 05.12.2019.
//  Copyright © 2019 Павел Пособило. All rights reserved.
//

import Foundation

class CocktailDBList<T: Codable>: NSObject, Codable {
    var items: [T]?
    
    enum CodingKeys: String, CodingKey {
        case items = "drinks"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.items = try! container.decode([T].self, forKey: .items)
    }
}
