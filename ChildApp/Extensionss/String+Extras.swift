//
//  String+Extras.swift
//  Saydaly
//
//  Created by Mohamed Elkassas on 11/27/17.
//  Copyright © 2017 Phantasm. All rights reserved.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: self)
    }
}
