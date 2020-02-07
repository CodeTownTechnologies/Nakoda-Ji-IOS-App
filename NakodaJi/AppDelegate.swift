//
//  AppDelegate.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 27/01/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//
//com.nakodaji
import UIKit
import CoreData
import Alamofire
import IQKeyboardManagerSwift
import Kingfisher
import UserNotifications
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let window = UIWindow(frame: UIScreen.main.bounds)
    var loginUser : LoginUser?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.toolbarTintColor = ColorOrange
        initiateRootVC(animated: false)
        
        //TODO: Firebase configuration
                
        let pushManager = PushNotificationManager()
        pushManager.registerForPushNotifications()
        pushManager.delegate = self
        
        if let userInfo = CUserDefaults.value(forKey: UserDefaultLoginUserData) {
            loginUser = LoginUser(object: userInfo)
        }
        
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        return true
    }


    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "NakodaJi")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}


extension AppDelegate {
    
    func initiateRootVC(animated: Bool) {
        
        let rootVC = UINavigationController.init(rootViewController: CMain_SB.instantiateViewController(withIdentifier: "HomeVC"))
        
        self.setWindowRootViewController(rootVC: rootVC, animated: animated, completion: nil)
    }
    
    func setWindowRootViewController(rootVC:UIViewController?, animated:Bool, completion: ((Bool) -> Void)?) {
        
        guard rootVC != nil else {
            return
        }
        
        UIApplication.shared.sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)
        
        UIView.transition(with: self.window, duration: animated ? 0.6 : 0.0, options: .transitionCrossDissolve, animations: {
            
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            
            self.window.rootViewController = rootVC
            UIView.setAnimationsEnabled(oldState)
        }) { (finished) in
            if let handler = completion {
                handler(true)
            }
        }
    }
}




extension AppDelegate : PushNotificationManagerDelegate {
    
    func didReceiveRegistrationToken(_ token: String) {
        CUserDefaults.set(token, forKey: UserDefaultDeviceToken)
        CUserDefaults.synchronize()
        
        APIRequest.shared.updateDeviceToken(param: ["user_id": loginUser?.id ?? "0"], successCompletion: { (complition) in
            
        }) { (error) in
            
        }
    }
}
