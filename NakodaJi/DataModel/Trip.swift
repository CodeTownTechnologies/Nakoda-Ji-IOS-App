//
//  Trip.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 07/02/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import Foundation
import UIKit

public final class Trip {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let description = "description"
        static let endDate = "end_date"
        static let startDate = "start_date"
        static let title = "title"
        static let totalBuses = "total_buses"
        static let id = "id"
        static let busesInfo = "buses_info"
        
    }
    
    // MARK: Properties
    
    public var description : String?
    public var endDate : String?
    public var startDate : String?
    public var title : String?
    public var totalBuses : String?
    public var busesInfo : String?
    public var id : String?
    public var arrBuses : [String]?
    
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
        description = json[SerializationKeys.description].string
        endDate = json[SerializationKeys.endDate].string
        startDate = json[SerializationKeys.startDate].string
        title = json[SerializationKeys.title].string
        totalBuses = json[SerializationKeys.totalBuses].string
        busesInfo = json[SerializationKeys.busesInfo].string
        if let arrString = busesInfo?.toJSON() as? [String] {
            self.arrBuses = arrString
        }
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = description { dictionary[SerializationKeys.description] = value }
        if let value = endDate { dictionary[SerializationKeys.endDate] = value }
        if let value = startDate { dictionary[SerializationKeys.startDate] = value }
        if let value = title { dictionary[SerializationKeys.title] = value }
        if let value = totalBuses { dictionary[SerializationKeys.totalBuses] = value }
        if let value = busesInfo { dictionary[SerializationKeys.busesInfo] = value }
        

        return dictionary
    }
    
}
