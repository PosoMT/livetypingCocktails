//
//  NetworkProvider.swift
//  livetyping
//
//  Created by Павел Пособило on 05.12.2019.
//  Copyright © 2019 Павел Пособило. All rights reserved.
//

import Foundation
import Moya

class NetworkProvider {
    
    private var cocktailProvider = MoyaProvider<CocktailService>()
    
    func fetchCategories(completion: @escaping (CocktailDBList<Category>?, Error?) -> ()) {
        cocktailProvider.request(.getCategories) { (response) in
            switch response.result {
            case .failure(let error):
                completion(nil, error)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let categoriesList: CocktailDBList<Category> = try decoder.decode(CocktailDBList<Category>.self, from: value.data)
                    completion(categoriesList, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        }
    }
    
    func fetchCocktails(category: String, completion: @escaping (CocktailDBList<Cocktail>?, Error?) -> ()) {
        cocktailProvider.request(.getCocktailsForCategory(category: category)) { (response) in
            switch response.result {
            case .failure(let error):
                completion(nil, error)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let cocktailsList: CocktailDBList<Cocktail> = try decoder.decode(CocktailDBList<Cocktail>.self, from: value.data)
                    completion(cocktailsList, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        }
    }
}
