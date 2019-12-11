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
    
    private var selectedCategories = [Category]()
    
    private var allCocktails = [[Cocktail]]()
    
    private var filteredCocktails = [[Cocktail]]()
    
    private var categoriesFiltered: Bool {
        return selectedCategories.isEmpty
    }
    
    init(delegate: CocktailsDataSourceDelegate) {
        self.delegate = delegate
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
    
    private func loadCocktailsForCategories(categories: [Category]) {
        var remainingCategories = categories
        guard let firstCategory = remainingCategories.first else { return }
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
    
    func loadCocktailsForSelectedCategories() {
        let categoriesToLoad = categoriesFiltered ? categories : selectedCategories
        loadCocktailsForCategories(categories: categoriesToLoad)
    }
    
    func setSelectedCategories(categories: [Category]) {
        selectedCategories.removeAll()
        selectedCategories.append(contentsOf: categories)
        filterCocktails()
    }
    
    private func filterCocktails() {
        filteredCocktails.removeAll()
        for selectedCategory in selectedCategories {
            guard let index = categories.firstIndex(of: selectedCategory) else { continue }
            filteredCocktails.append(allCocktails[index])
        }
    }
    
    private func cocktailsDidLoadForCategory(category: Category, cocktails: CocktailDBList<Cocktail>) {
        guard let categoryIndex = categories.firstIndex(of: category),
            let downloadedCocktails = cocktails.items else { return }
        self.allCocktails.append(downloadedCocktails)
        delegate?.cocktailsLoadedForSection(section: categoryIndex)
    }
    
    func numberOfSections() -> Int {
       return categoriesFiltered ? categories.count : selectedCategories.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        guard allCocktails.count > section else { return 0 }
        return categoriesFiltered ? allCocktails[section].count : filteredCocktails[section].count
    }
    
    func categoryForSection(_ section: Int) -> Category {
        return categoriesFiltered ? categories[section] : selectedCategories[section]
    }
    
    func cocktailForIndex(indexPath: IndexPath) -> Cocktail {
        return categoriesFiltered ? allCocktails[indexPath.section][indexPath.row] : filteredCocktails[indexPath.section][indexPath.row]
    }
    
    func getAllCategories() -> [Category] {
        return categories
    }
    
    func getSelectedCategories() -> [Category] {
        return selectedCategories
    }

}
