//
//  ExtensionUIApplication.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 05/02/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Extension of UIApplication For getting the TopMostViewController(UIViewController) of Application.
extension UIApplication {
    
    func topMostViewController(viewController : UIViewController? = CSharedApplication.keyWindow?.rootViewController) -> UIViewController? {
        
        if let navigationViewController = viewController as? UINavigationController {
            
            return CSharedApplication.topMostViewController(viewController: navigationViewController.visibleViewController)
        }
        
        if let tabBarViewController = viewController as? UITabBarController {
            
            if let selectedViewController = tabBarViewController.selectedViewController {
                
                return CSharedApplication.topMostViewController(viewController: selectedViewController)
            }
        }
        
        if let presentedViewController = viewController?.presentedViewController {
            
            return CSharedApplication.topMostViewController(viewController: presentedViewController)
        }
        
        return viewController
    }
}
