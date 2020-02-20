//
//  AppConstant.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 27/01/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import Foundation
import UIKit

let CMainScreen = UIScreen.main
let CBounds = CMainScreen.bounds

let CScreenSize = CBounds.size
let CScreenWidth = CScreenSize.width
let CScreenHeight = CScreenSize.height

let CMain_SB                 = UIStoryboard(name: "Main", bundle: nil)

let ColorBlack_000000           = CRGB(r: 0, g: 0, b: 0)
let ColorWhite_FFFFFF           = CRGB(r: 255, g: 255, b: 255)
let ColorOrange                 = CRGB(r: 239, g: 104, b: 55)


let CUserDefaults = UserDefaults.standard
let CSharedApplication = UIApplication.shared
let appDelegate = CSharedApplication.delegate as? AppDelegate
var CTopMostViewController:UIViewController? {
    get {
        if let topVC = CSharedApplication.topMostViewController() {
            return topVC
        }
        return nil
    }
    set
    {}
}


//MARK:-
//MARK:- Fonts
public enum CFontType:Int {
    case Black
    case BlackItalic
    case Bold
    case BoldItalic
    case SemiBold
    case SemiBoldItalic
    case Italic
    case Light
    case Medium
    case Regular
}


func CFontNotoSans(size: CGFloat, type: CFontType) -> UIFont {
    
    switch type {
        
    case .Bold:
        return UIFont.init(name: "NotoSans-Bold", size: size)!
        
    case .BoldItalic:
        return UIFont.init(name: "NotoSans-BoldItalic", size: size)!
        
    case .Italic:
        return UIFont.init(name: "NotoSans-Italic", size: size)!
        
    default :
        return UIFont.init(name: "NotoSans-Regular", size: size)!
    }
}

func CFontPoppins(size: CGFloat, type: CFontType) -> UIFont {
    
    switch type {
        
//    case .Bold:
//        return UIFont.init(name: "Poppins-Bold", size: size)!
        
    case .Light:
        return UIFont.init(name: "Poppins-Light", size: size)!
        
    case .Medium:
        return UIFont.init(name: "Poppins-Medium", size: size)!
        
    case .Bold, .SemiBold:
        return UIFont.init(name: "Poppins-SemiBold", size: size)!
        
    default :
        return UIFont.init(name: "Poppins-Regular", size: size)!
    }
}

func CRGB(r:CGFloat , g:CGFloat , b:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
}

func CRGBA(r:CGFloat , g:CGFloat , b:CGFloat , a:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}
