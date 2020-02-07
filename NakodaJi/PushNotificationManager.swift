//
//  PushNotificationManager.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 06/02/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import Foundation
import UIKit

import Firebase
import FirebaseMessaging
import UserNotifications

public protocol PushNotificationManagerDelegate : class {
    
    func didReceiveRegistrationToken(_ token: String)
}

class PushNotificationManager: NSObject, MessagingDelegate, UNUserNotificationCenterDelegate {

    var delegate : PushNotificationManagerDelegate?
    override init() {
        super.init()
        FirebaseApp.configure()
    }
    

    func registerForPushNotifications() {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            // For iOS 10 data message (sent via FCM)
            Messaging.messaging().delegate = self
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }

        UIApplication.shared.registerForRemoteNotifications()
        updateFirestorePushTokenIfNeeded()
    }

    func updateFirestorePushTokenIfNeeded() {
        if let token = Messaging.messaging().fcmToken {
            
            print("fcm register token = \(token)")
            delegate?.didReceiveRegistrationToken(token)
            
        }
    }

    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
    }

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        updateFirestorePushTokenIfNeeded()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response)
        completionHandler()
    }
}
