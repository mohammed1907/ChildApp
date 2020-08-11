//
//  UIViewController+Extras.swift
//  Saydaly
//
//  Created by Farghaly on 2/20/20.
//  Copyright © 2020 . All rights reserved.
//

import UIKit
import PKHUD

extension UIViewController {
    func showBlockingLoading()  {
        HUD.dimsBackground = true
        HUD.allowsInteraction = false
        HUD.show(.progress)
    }

    func hideBlockingLoading()  {
        HUD.hide()
    }
    
    func showAlertMessage(message: String)  {
        HUD.flash(.label(message), delay: 3.0)
    }
    
    func showErrorMessage(message: String)  {
        HUD.flash(.labeledProgress(title: "Error", subtitle: message), delay: 2.0)
    }
    
    func showMessage(message: String)  {
        HUD.flash(.label(message), delay: 2.0)
    }
    
    // Get ViewController in top present level
    var topPresentedViewController: UIViewController? {
        var target: UIViewController? = self
        while (target?.presentedViewController != nil) {
            target = target?.presentedViewController
        }
        return target
    }
    
    // Get top VisibleViewController from ViewController stack in same present level.
    // It should be visibleViewController if self is a UINavigationController instance
    // It should be selectedViewController if self is a UITabBarController instance
    var topVisibleViewController: UIViewController? {
        if let navigation = self as? UINavigationController {
            if let visibleViewController = navigation.visibleViewController {
                return visibleViewController.topVisibleViewController
            }
        }
        if let tab = self as? UITabBarController {
            if let selectedViewController = tab.selectedViewController {
                return selectedViewController.topVisibleViewController
            }
        }
        return self
    }
    
    // Combine both topPresentedViewController and topVisibleViewController methods, to get top visible viewcontroller in top present level
    var topMostViewController: UIViewController? {
        return self.topPresentedViewController?.topVisibleViewController
    }
}
