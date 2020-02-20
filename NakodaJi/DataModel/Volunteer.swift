//
//  Volunteer.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 08/02/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import Foundation

public final class Volunteer {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let addDate = "add_date"
        static let email = "email"
        static let firstName = "first_name"
        static let lastName = "last_name"
        static let id = "id"
        static let salutation = "salutation"
        static let mobileNo = "mobileno"
        static let phoneCode = "phone_code"
        static let image = "image"
        
    }
    
    // MARK: Properties
    
    public var addDate : String?
    public var email : String?
    public var fullName : String?
    public var firstName : String?
    public var lastName : String?
    public var salutation : String?
    public var image : String?
    public var id : String?
    public var mobileNo : String = ""
    public var phoneCode : String = ""
    public var fullContact : String = ""
    
    // MARK: SwiftyJSON Initializers
    /// Initiates the instance based on the object.
    ///
    /// - parameter object: The object of either Dictionary or Array kind that was passed.
    /// - returns: An initialized instance of the class.
    public convenience init(object: Any) {
        self.init(json: JSON(object))
    }
    
    /// Initiates the instance based on the JSON that was passed.
    ///
    /// - parameter json: JSON object from SwiftyJSON.
    public required init(json: JSON) {
        
        id = json[SerializationKeys.id].stringValue
        addDate = json[SerializationKeys.addDate].string
        email = json[SerializationKeys.email].stringValue
        firstName = json[SerializationKeys.firstName].string
        lastName = json[SerializationKeys.lastName].stringValue
        salutation = json[SerializationKeys.salutation].stringValue
        mobileNo = json[SerializationKeys.mobileNo].stringValue
        phoneCode = json[SerializationKeys.phoneCode].stringValue
        image = json[SerializationKeys.image].stringValue
        
        fullContact = ""
        
        if !phoneCode.isEmpty{
            fullContact = phoneCode + "-"
        }
        
        if !mobileNo.isEmpty {
            fullContact = fullContact + mobileNo
        }
        
        if let sal = salutation, !sal.isEmpty {
            fullName = sal + " "
        }
        
        if let fName = firstName, !fName.isEmpty {
            fullName =  (fullName ?? "") + fName + " "
        }
        
        if let lName = lastName, !lName.isEmpty {
            fullName = (fullName ?? "") + lName
        }
    }
        
}
