//
//  CocktailService.swift
//  livetyping
//
//  Created by Павел Пособило on 05.12.2019.
//  Copyright © 2019 Павел Пособило. All rights reserved.
//

import Moya

enum CocktailService {
    case getCategories
    case getCocktailsForCategory(category: String)
}

extension CocktailService: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/") else {
            fatalError("Base URL is not set")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getCategories:
            return "list.php"
        case .getCocktailsForCategory:
            return "filter.php"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getCategories:
            let parameters = ["c": "list"]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .getCocktailsForCategory(let category):
            let parameters = ["c": category]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
}
