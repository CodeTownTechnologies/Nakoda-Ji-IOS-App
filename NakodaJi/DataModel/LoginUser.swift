//
//  LoginUser.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 06/02/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import Foundation

public final class LoginUser {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let addDate = "add_date"
        static let address = "address"
        static let city = "city"
        static let countryId = "country_id"
        static let countryName = "country_name"
        static let dob = "dob"
        static let email = "email"
        static let firstName = "first_name"
        static let gender = "gender"
        static let id = "id"
        static let lastName = "last_name"
        static let mobileNo = "mobileno"
        static let postCode = "postcode"
        static let stateId = "state_id"
        static let stateName = "state_name"
        static let street = "street"
    }
    
    // MARK: Properties
    
    public var addDate : String?
    public var address : String?
    public var city : String?
    public var countryId : String?
    public var countryName : String?
    public var dob : String?
    public var email : String?
    public var firstName : String?
    public var gender : String?
    public var id : String?
    public var lastName : String?
    public var mobileNo : String?
    public var postCode : String?
    public var stateId : String?
    public var stateName : String?
    public var street : String?
    
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
        
        addDate = json[SerializationKeys.addDate].stringValue
        address = json[SerializationKeys.address].stringValue
        city = json[SerializationKeys.city].stringValue
        countryId = json[SerializationKeys.countryId].stringValue
        countryName = json[SerializationKeys.countryName].stringValue
        dob = json[SerializationKeys.dob].stringValue
        email = json[SerializationKeys.email].stringValue
        firstName = json[SerializationKeys.firstName].stringValue
        gender = json[SerializationKeys.gender].stringValue
        id = json[SerializationKeys.id].stringValue
        lastName = json[SerializationKeys.lastName].stringValue
        mobileNo = json[SerializationKeys.mobileNo].stringValue
        postCode = json[SerializationKeys.postCode].stringValue
        stateId = json[SerializationKeys.stateId].stringValue
        stateName = json[SerializationKeys.stateName].stringValue
        street = json[SerializationKeys.street].stringValue
                
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = addDate { dictionary[SerializationKeys.addDate] = value }
        if let value = address { dictionary[SerializationKeys.address] = value }
        if let value = city { dictionary[SerializationKeys.city] = value }
        if let value = countryId { dictionary[SerializationKeys.countryId] = value }
        if let value = countryName { dictionary[SerializationKeys.countryName] = value }
        if let value = dob { dictionary[SerializationKeys.dob] = value }
        if let value = email { dictionary[SerializationKeys.email] = value }
        if let value = firstName { dictionary[SerializationKeys.firstName] = value }
        if let value = gender { dictionary[SerializationKeys.gender] = value }
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = lastName { dictionary[SerializationKeys.lastName] = value }
        if let value = mobileNo { dictionary[SerializationKeys.mobileNo] = value }
        if let value = postCode { dictionary[SerializationKeys.postCode] = value }
        if let value = stateId { dictionary[SerializationKeys.stateId] = value }
        if let value = stateName { dictionary[SerializationKeys.stateName] = value }
        if let value = street { dictionary[SerializationKeys.street] = value }

        return dictionary
    }
    
}

