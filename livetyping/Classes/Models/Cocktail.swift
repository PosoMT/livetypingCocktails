//
//  Cocktail.swift
//  livetyping
//
//  Created by Павел Пособило on 05.12.2019.
//  Copyright © 2019 Павел Пособило. All rights reserved.
//

import Foundation

struct Cocktail: Codable {
    
    // MARK: Properties
    
    var strDrink: String
    var strDrinkThumb: String
    
    // MARK: Initialization
    
    enum CodingKeys: String, CodingKey {
        case strDrink
        case strDrinkThumb
    }
    
}

extension Cocktail {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.strDrink = try! container.decode(String.self, forKey: .strDrink)
        self.strDrinkThumb = try! container.decode(String.self, forKey: .strDrinkThumb)
    }
    
}
