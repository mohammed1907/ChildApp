//
//  UIViewController+Identifier.swift
//  Saydaly
//
//  Created by Farghaly on 2/20/20.
//  Copyright © 2020 . All rights reserved.
//

import UIKit

extension UIViewController {
    
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIViewController {
    open override func awakeFromNib() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
