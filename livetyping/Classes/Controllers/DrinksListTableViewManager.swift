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
    private let heightForRow = 88
    
    private var dataSource: CocktailsDataSource
    
    init(dataSource: CocktailsDataSource) {
        self.dataSource = dataSource
    }
}

//MARK: - UITableViewDataSource

extension DrinksListTableViewManager: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DrinksTableViewCell.reuseIdentifier) as! DrinksTableViewCell
        cell.setTitle(title: dataSource.cocktailForIndex(indexPath: indexPath).strDrink)
        cell.setImage(path: dataSource.cocktailForIndex(indexPath: indexPath).strDrinkThumb)
        return cell
    }
    
}

//MARK: - UITableViewDataSource

extension DrinksListTableViewManager: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(heightForRow)
    }
    
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
