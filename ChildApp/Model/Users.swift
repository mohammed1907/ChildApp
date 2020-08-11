//
//  Users.swift
//  ParentApp
//
//  Created by Youm7 on 8/7/20.
//  Copyright © 2020 Test.iosapp. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String?
    var email: String?
    var key : String?
    init(dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        
    }
}
