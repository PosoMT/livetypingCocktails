//
//  ViewController.swift
//  livetyping
//
//  Created by Павел Пособило on 03.12.2019.
//  Copyright © 2019 Павел Пособило. All rights reserved.
//

import UIKit
import Moya
import MBProgressHUD

class DrinksListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    private var tableViewManager: DrinksListTableViewManager!
    private lazy var dataSource = CocktailsDataSource(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        configureTableView()
    }
    
    private func configureDataSource() {
        MBProgressHUD.showAdded(to: tableView, animated: true)
        dataSource.loadCategories()
    }
    
    private func configureTableView() {
        tableViewManager = DrinksListTableViewManager(dataSource: dataSource)
        tableView.delegate = tableViewManager
        tableView.dataSource = tableViewManager
    }
}

extension DrinksListViewController: CocktailsDataSourceDelegate {
    func categoriesLoaded() {
        MBProgressHUD.hide(for: tableView, animated: true)
        tableView.reloadData()
        dataSource.loadAllCocktails()
    }
    
    func cocktailsLoadedForSection(section: Int) {
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
}

protocol CocktailsDataSourceDelegate: class {
    func categoriesLoaded()
    func cocktailsLoadedForSection(section: Int)
}

