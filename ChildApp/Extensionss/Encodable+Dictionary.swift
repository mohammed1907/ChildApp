//
//  Encodable+Dictionary.swift
//  Noospets
//
//  Created by Mohamed Elkassas on 7/31/19.
//  Copyright © 2019 Phantasm. All rights reserved.
//

import UIKit

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
