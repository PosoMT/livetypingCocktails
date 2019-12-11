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
        configureNavigationBar()
    }
    
    private func configureDataSource() {
        MBProgressHUD.showAdded(to: tableView, animated: true)
        dataSource.loadCategories()
    }
    
    private func configureTableView() {
        tableViewManager = DrinksListTableViewManager(dataSource: dataSource)
        tableView.register(UINib(nibName: DrinksTableViewCell.reuseIdentifier, bundle: .main), forCellReuseIdentifier: DrinksTableViewCell.reuseIdentifier)
        tableView.delegate = tableViewManager
        tableView.dataSource = tableViewManager
    }
    
    private func configureNavigationBar() {
        let rightBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "filter"), style: .plain, target: self, action: #selector(filterButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButton
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func configureFilterImage(filterIsSet: Bool) {
        navigationItem.rightBarButtonItem?.image = filterIsSet ? #imageLiteral(resourceName: "filterset") : #imageLiteral(resourceName: "filter")
    }
    
    @objc private func filterButtonTapped() {
        let filtersVC = FiltersListViewController.instantiate(categories: dataSource.getAllCategories(), selectedCategories: dataSource.getSelectedCategories(), delegate: self)
        navigationController?.pushViewController(filtersVC, animated: true)
    }
}

//MARK: - CocktailsDataSourceDelegate

extension DrinksListViewController: CocktailsDataSourceDelegate {
    func categoriesLoaded() {
        MBProgressHUD.hide(for: tableView, animated: true)
        tableView.reloadData()
        dataSource.loadCocktailsForSelectedCategories()
    }
    
    func cocktailsLoadedForSection(section: Int) {
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
}

//MARK: - FiltersListDelegate

extension DrinksListViewController: FiltersListDelegate {
    func setSelectedCategories(categories: [Category]) {
        dataSource.setSelectedCategories(categories: categories)
        configureFilterImage(filterIsSet: !categories.isEmpty)
        tableView.reloadData()
    }
}

//MARK: - Protocols

protocol CocktailsDataSourceDelegate: class {
    func categoriesLoaded()
    func cocktailsLoadedForSection(section: Int)
}

protocol FiltersListDelegate: class {
    func setSelectedCategories(categories: [Category])
}

