//
//  ApplicationConstants.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 05/02/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//


import Foundation
import UIKit

//MARK:-
//MARK:- Status

let CJsonResponse       = "response"
let CJsonMessage        = "message"
let CJsonStatus         = "status"
let CStatusCode         = "status_code"
let CReplayStatusCode   = "replyStatus"
let CStatusSuccess      = "success"
let CReplyMessage        = "replyMessage"
let CJsonTitle          = "title"
let CJsonData           = "data"
let CJsonMeta           = "meta"
let CVerificationStatus = "verification_status"

let CLimit              = 20

let CStatusZero         = 0
let CStatusOne          = 1
let CStatusTwo          = 2
let CStatusThree        = 3
let CStatusFour         = 4
let CStatusFive         = 5
let CStatusEight        = 8
let CStatusNine         = 9
let CStatusTen          = 10
let CStatusEleven       = 11

let CStatus200         = 200
let CStatus401         = 401


let CVarificationDone                   = 0
let CVarificationEmailPending           = 1
let CVarificationEmailMobilePending     = 2
let CVarificationMobilePending          = 3

let CStatusTwoHundred   = NSNumber(value: 200 as Int)       //  Success
let CStatusFourHundredAndOne = NSNumber(value: 401 as Int)     //  Unauthorized user access
let CStatusFiveHundredAndFiftyFive = NSNumber(value: 555 as Int)   //  Invalid request
let CStatusFiveHundredAndFiftySix = NSNumber(value: 556 as Int)   //  Invalid request
let CStatusFiveHundredAndFifty = NSNumber(value: 550 as Int)        //  Inactive/Delete user
let CStatusFiveHunred   = NSNumber(value: 500 as Int)



//MARK:-
//MARK:- UserDefaults Keys


let UserDefaultDeviceToken          = "UserDefaultDeviceToken"
let UserDefaultLoginUserToken       = "UserDefaultLoginUserToken"
let UserDefaultLoginUserID          = "UserDefaultLoginUserID"
let UserDefaultAppCurrentVersion    = "UserDefaultAppCurrentVersion"

let UserDefaultLoginUserData        = "UserDefaultLoginUserData"


//MARK:-
//MARK:- Notification Identifier
let RefreshSideMenuNotification     = "RefreshSideMenuNotification"


//MARK:-
//MARK:- Other

let CBtnOk                          = "Ok"
let CBtnCancel                      = "Cancel"
let CBtnYes                         = "Yes"
let CBtnNo                          = "No"
let CBtnClose                       = "Close"
let CBtnSkip                        = "Skip"
let CBtnRetry                       = "Retry"
let CBtnOpenSettings                = "Open Settings"
let CUserAgent                      = "mobile"


let CCurrencyRs                     = "₹ "


//MARK:-
//MARK:- Image Name Constant
let CImageWorried                = "sorryno_icon"
let CImageNoFeed                 = "sorryno_icon"
let CImageCartLarge              = "cart_large"


//MARK:-
//MARK:- Disable print for production.

func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
        Swift.print(items[0], separator:separator, terminator: terminator)
    #endif
}
