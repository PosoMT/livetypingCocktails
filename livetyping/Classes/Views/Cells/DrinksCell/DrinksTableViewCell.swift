//
//  DrinksTableViewCell.swift
//  livetyping
//
//  Created by Павел Пособило on 10.12.2019.
//  Copyright © 2019 Павел Пособило. All rights reserved.
//

import UIKit
import SDWebImage

class DrinksTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var cocktailImageView: UIImageView!
    
    func setTitle(title: String) {
        self.title.text = title
    }
    
    func setImage(path: String) {
        cocktailImageView.sd_setImage(with: URL(string: path), placeholderImage: #imageLiteral(resourceName: "placeholder"))
    }
    
}
