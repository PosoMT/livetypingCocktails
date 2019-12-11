//
//  FiltersListViewController.swift
//  livetyping
//
//  Created by Павел Пособило on 10.12.2019.
//  Copyright © 2019 Павел Пособило. All rights reserved.
//

import UIKit

class FiltersListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var applyButton: UIButton!
    
    @IBAction func applyButtonClicked(_ sender: Any) {
        delegate?.setSelectedCategories(categories: selectedCategories)
    }
    
    private var categories = [Category]()
    private var selectedCategories = [Category]()
    private var delegate: FiltersListDelegate?
    
    public static func instantiate(categories: [Category], selectedCategories: [Category], delegate: FiltersListDelegate) -> FiltersListViewController {
        let storyboard = UIStoryboard(name: "Filters", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "FiltersViewController") as! FiltersListViewController
        vc.categories = categories
        vc.selectedCategories = selectedCategories
        vc.delegate = delegate
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureApplyButton()
        configureTableView()
    }
    
    private func configureApplyButton() {
        applyButton.layer.borderColor = UIColor.black.cgColor
        applyButton.layer.borderWidth = 1
        applyButton.layer.cornerRadius = 8
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: FilterTableViewCell.reuseIdentifier, bundle: .main), forCellReuseIdentifier: FilterTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension FiltersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCategory = categories[indexPath.row]
        let categoryIsSelected = selectedCategories.contains(currentCategory)
        let selectedCell = tableView.cellForRow(at: indexPath) as! FilterTableViewCell
        if categoryIsSelected {
            selectedCell.setCheckmark(enabled: false)
            selectedCategories.removeAll { (element) -> Bool in
                return element == currentCategory
            }
        } else {
            selectedCell.setCheckmark(enabled: true)
            selectedCategories.append(currentCategory)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FiltersListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.reuseIdentifier) as! FilterTableViewCell
        cell.setTitle(title: categories[indexPath.row].strCategory)
        cell.setCheckmark(enabled: selectedCategories.contains(categories[indexPath.row]))
        return cell
    }
    
    
}
