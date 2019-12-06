//
//  DrinksListTableViewManager.swift
//  livetyping
//
//  Created by Павел Пособило on 06.12.2019.
//  Copyright © 2019 Павел Пособило. All rights reserved.
//

import Foundation
import UIKit

class DrinksListTableViewManager: NSObject {
    private var dataSource: CocktailsDataSource
    
    init(dataSource: CocktailsDataSource) {
        self.dataSource = dataSource
    }
}

extension DrinksListTableViewManager: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = dataSource.cocktailForIndex(indexPath: indexPath).strDrink
        return cell
    }
    
}

extension DrinksListTableViewManager: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UITableViewHeaderFooterView()
        let category = dataSource.categoryForSection(section)
        headerView.textLabel?.text = category.strCategory
        return headerView
    }
    
}
