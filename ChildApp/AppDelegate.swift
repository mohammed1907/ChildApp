//
//  AppDelegate.swift
//  ParentApp
//
//  Created by Youm7 on 8/6/20.
//  Copyright © 2020 Test.iosapp. All rights reserved.
//

import UIKit
import Firebase
import GoogleMaps
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      GMSServices.provideAPIKey("AIzaSyB086ejostox4c_Z6GxnRdMU-fKaTl-hYg")
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true

        // Override point for customization after application launch.
        return true
    }

  

}

