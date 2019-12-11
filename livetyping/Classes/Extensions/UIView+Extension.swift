//
//  UIView+Extension.swift
//  livetyping
//
//  Created by Павел Пособило on 10.12.2019.
//  Copyright © 2019 Павел Пособило. All rights reserved.
//

import UIKit

extension UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
