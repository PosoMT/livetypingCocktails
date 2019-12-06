//
//  CocktailsDataSource.swift
//  livetyping
//
//  Created by Павел Пособило on 05.12.2019.
//  Copyright © 2019 Павел Пособило. All rights reserved.
//

import Foundation

class CocktailsDataSource {
    
    private weak var delegate: CocktailsDataSourceDelegate?
    
    private let networkProvider = NetworkProvider()
    
    private var categories = [Category]()
    
    private var cocktails = [[Cocktail]]()
    
    init(delegate: CocktailsDataSourceDelegate) {
        self.delegate = delegate
    }
    
    func test() {
        loadCategories()
    }
    
    func loadCategories() {
        networkProvider.fetchCategories { (result, error) in
            if let error = error {
                print(error)
                return
            } else {
                self.categoriesDidLoad(list: result!)
            }
        }
    }
    
    private func categoriesDidLoad(list: CocktailDBList<Category>) {
        guard let categories = list.items else { return }
        self.categories = categories
        delegate?.categoriesLoaded()
    }
    
    func loadCocktailsForCategory(category: Category) {
        networkProvider.fetchCocktails(category: category.strCategory) { (result, error) in
            if let error = error {
                print(error)
                return
            } else {
                self.cocktailsDidLoadForCategory(category: category, cocktails: result!)
            }
        }
    }
    
    private func loadCocktailsForCategories(categories: [Category]) {
        var remainingCategories = categories
        guard let firstCategory = remainingCategories.first else {
//            self.delegate?.allLoaded()
            return
            
        }
        networkProvider.fetchCocktails(category: firstCategory.strCategory) { (result, error) in
            if let error = error {
                print(error)
            } else {
                self.cocktailsDidLoadForCategory(category: firstCategory, cocktails: result!)
                remainingCategories.removeFirst()
                self.loadCocktailsForCategories(categories: remainingCategories)
            }
        }
    }
    
    func loadAllCocktails() {
        loadCocktailsForCategories(categories: categories)
    }
    
    private func cocktailsDidLoadForCategory(category: Category, cocktails: CocktailDBList<Cocktail>) {
        guard let categoryIndex = categories.firstIndex(of: category),
            let downloadedCocktails = cocktails.items else { return }
        self.cocktails.append(downloadedCocktails)
        delegate?.cocktailsLoadedForSection(section: categoryIndex)
    }
    
    func numberOfSections() -> Int {
        return categories.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        guard cocktails.count > section else { return 0 }
        return cocktails[section].count
    }
    
    func categoryForSection(_ section: Int) -> Category {
        return categories[section]
    }
    
    func cocktailForIndex(indexPath: IndexPath) -> Cocktail {
        return cocktails[indexPath.section][indexPath.row]
    }

}
