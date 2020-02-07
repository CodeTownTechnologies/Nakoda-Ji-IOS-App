//
//  ExtensionViewController.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 30/01/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import Foundation
import UIKit

typealias alertActionHandler = ((UIAlertAction) -> ())?

// MARK: - Extension of UIViewController For AlertView with Different Numbers of Buttons
extension UIViewController {
    
    /// This Method is used to show AlertView with one Button.
    ///
    /// - Parameters:
    ///   - alertTitle: A String value that indicates the title of AlertView , it is Optional so you can pass nil if you don't want Alert Title.
    ///   - alertMessage: A String value that indicates the title of AlertView , it is Optional so you can pass nil if you don't want alert message.
    ///   - btnOneTitle: A String value - Title of button.
    ///   - btnOneTapped: Button Tapped Handler (Optional - you can pass nil if you don't want any action).
    func presentAlertViewWithOneButton(alertTitle:String? , alertMessage:String? , btnOneTitle:String , btnOneTapped:alertActionHandler?) {
        
        let alertController = UIAlertController(title: alertTitle ?? "", message: alertMessage ?? "", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: btnOneTitle, style: .default, handler: btnOneTapped ?? nil))
        
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentAlertViewWithTwoButtons(alertTitle:String? , alertMessage:String? , btnOneTitle:String , btnOneTapped:alertActionHandler , btnTwoTitle:String , btnTwoTapped:alertActionHandler) {
        
        let alertController = UIAlertController(title: alertTitle ?? "", message: alertMessage ?? "", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: btnOneTitle, style: .default, handler: btnOneTapped))
        
        alertController.addAction(UIAlertAction(title: btnTwoTitle, style: .default, handler: btnTwoTapped))
        
        self.present(alertController, animated: true, completion: nil)
    }
}


// MARK:-
// MARK:- Show Alerts

extension UIViewController {
    
    func showAlertView(_ message : String?, title : String = "", completion: alertActionHandler?) {
        self.presentAlertViewWithOneButton(alertTitle: title, alertMessage: message, btnOneTitle: CBtnOk, btnOneTapped: completion)
    }
    
}
