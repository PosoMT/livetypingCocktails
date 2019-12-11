//
//  FilterTableViewCell.swift
//  livetyping
//
//  Created by Павел Пособило on 10.12.2019.
//  Copyright © 2019 Павел Пособило. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!

    func setTitle(title: String) {
        self.title.text = title
    }
    
    func setCheckmark(enabled: Bool) {
        self.accessoryType = enabled ? .checkmark : .none
    }
    
}
