//
//  Passenger.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 07/02/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import Foundation
import UIKit

public final class Passenger {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let addDate = "add_date"
        static let busNumber = "bus_number"
        static let fullName = "full_name"
        static let seatNumber = "seat_number"
        static let tripId = "trip_id"
        static let id = "id"
        static let userId = "user_id"
        static let mobileNo = "mobileno"
        static let phoneCode = "phone_code"
        static let gender = "gender"
        
    }
    
    // MARK: Properties
    
    public var addDate : String?
    public var busNumber : String?
    public var fullName : String?
    public var seatNumber : String?
    public var tripId : String?
    public var userId : String?
    public var id : String?
    public var mobileNo : String = ""
    public var phoneCode : String = ""
    public var gender : String?
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
        fullName = json[SerializationKeys.fullName].string
        seatNumber = json[SerializationKeys.seatNumber].stringValue
        busNumber = json[SerializationKeys.busNumber].string
        tripId = json[SerializationKeys.tripId].stringValue
        userId = json[SerializationKeys.userId].stringValue
        mobileNo = json[SerializationKeys.mobileNo].stringValue
        phoneCode = json[SerializationKeys.phoneCode].stringValue
        gender = json[SerializationKeys.gender].stringValue
        fullContact = ""
        
        if !phoneCode.isEmpty{
            fullContact = phoneCode + "-"
        }
        
        if !mobileNo.isEmpty {
            fullContact = fullContact + mobileNo
        }
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = addDate { dictionary[SerializationKeys.addDate] = value }
        if let value = fullName { dictionary[SerializationKeys.fullName] = value }
        if let value = seatNumber { dictionary[SerializationKeys.seatNumber] = value }
        if let value = busNumber { dictionary[SerializationKeys.busNumber] = value }
        if let value = tripId { dictionary[SerializationKeys.tripId] = value }
        if let value = userId { dictionary[SerializationKeys.userId] = value }
        if let value = gender { dictionary[SerializationKeys.gender] = value }
          dictionary[SerializationKeys.mobileNo] = mobileNo
          dictionary[SerializationKeys.phoneCode] = phoneCode
        return dictionary
    }
    
}
