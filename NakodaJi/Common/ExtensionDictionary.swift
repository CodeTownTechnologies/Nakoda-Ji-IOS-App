//
//  ExtensionDictionary.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 28/01/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import Foundation
import  UIKit
// MARK: - Extension of Dictionary For getting the different types of values from it.
extension Dictionary {
    
    func valueForString(key:String) -> String {
        
        if let dictionary = self as? [String:Any] {
            
            return "\(dictionary[key] ?? "")"
            
        } else {
            return ""
        }
    }
    
    func valueForInt(key:String) -> Int? {
        return self.valueForString(key: key).toInt
    }
    
    func valueForDouble(key:String) -> Double? {
        return self.valueForString(key: key).toDouble
    }
    
    func valueForFloat(key:String) -> Float? {
        return self.valueForString(key: key).toFloat
    }
    
    func valueForJSON(key:String) -> Any? {
        
        if let dictionary = self as? [String:Any] {
            
            return dictionary[key] ?? nil
            
        } else {
            return nil
        }
    }
    
    func valueForBool(key:String) -> Bool {
        
        if let dictionary = self as? [String:Any] {
            
            switch dictionary[key] {
            case let string as String:
                
                if let value = Int(string), value > 0 {
                    return true
                    
                }else if string == "1" || string.lowercased() == "true" || string.lowercased() == "yes"{
                    return true
                }
            case let int as Int:
                if int > 0  {
                    return true
                }
            case let bool as Bool:
                return bool
            default:
                return false
            }
        }
        
        return false
    }
    
    func valueForImage(key:String) -> UIImage? {
        
        if let dictionary = self as? [String:Any] {
            if let image = dictionary[key] as? UIImage {
                return image
            } else if let imageName = dictionary[key] as? String,
                let image = UIImage(named: imageName) {
                return image
            }
        }
        
        return nil
        
    }
    
    func value(forKey:String) -> Any? {
        
        if let dictionary = self as? [String:Any] {
            if let value = dictionary[forKey
                ] {
                return value
            }
        }
        
        return nil
        
    }
}

// MARK: - Extension of String For Converting it TO Int AND URL.
extension String {
    
    /// A Computed Property (only getter) of Int For getting the Int? value from String.
    /// This Computed Property (only getter) returns Int? , it means this Computed Property (only getter) return nil value also , while using this Computed Property (only getter) please use if let. If you are not using if let and if this Computed Property (only getter) returns nil and when you are trying to unwrapped this value("Int!") then application will crash.
    var toInt:Int? {
        return Int(self)
    }
    
    var toDouble:Double? {
        return Double(self)
    }
    
    var toFloat:Float? {
        return Float(self)
    }
    
    
    /// A Computed Property (only getter) of URL For getting the URL from String.
    /// This Computed Property (only getter) returns URL? , it means this Computed Property (only getter) return nil value also , while using this Computed Property (only getter) please use if let. If you are not using if let and if this Computed Property (only getter) returns nil and when you are trying to unwrapped this value("URL!") then application will crash.
    var toURL:URL? {
        return URL(string: self)
    }
    
}



extension String {
    
    var trim:String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var isBlank:Bool {
        return self.trim.isEmpty
    }
    
    var isAlphanumeric:Bool {
        return !isBlank && rangeOfCharacter(from: .alphanumerics) != nil
    }
    
    var isValidEmail:Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with:self.trim)
    }
    
    var isValidPassword:Bool {
        //https://stackoverflow.com/questions/39284607/how-to-implement-a-regex-for-password-validation-in-swift
//        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
//        let predicate = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
//        return predicate.evaluate(with:self)
        
        return self.trim.count >= 4
        
//        if self.count < 8 {
//            return false
//        }else {
//            return self.isValidAlphabets
//        }
    }
    
    
    var isValidPhoneNo:Bool {
        
        //let phoneRegex = "^[0-9]{7,16}$"
        let phoneRegex = "^[0-9]{10,10}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", phoneRegex)
        return predicate.evaluate(with:self)
    }
    
    var isValidAlphabets:Bool {
        let alphaRegex = "^(?=.*[a-zA-Z]).{1,}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", alphaRegex)
        return predicate.evaluate(with:self)
        
    }
    
    var isValidName:Bool {
        
        let alphaRegex = "^[A-Za-z ]{1,}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", alphaRegex)
        return predicate.evaluate(with:self)
        
    }
}


extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}


extension String {
    func components(withMaxLength length: Int) -> [String] {
        return stride(from: 0, to: self.count, by: length).map {
            let start = self.index(self.startIndex, offsetBy: $0)
            let end = self.index(start, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            return String(self[start..<end])
        }
    }
}
