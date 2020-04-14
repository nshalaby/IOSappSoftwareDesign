//
//  Organizations.swift
//  WasteManagement
//
//  Created by Nadia Shalaby on 2020-03-29.
//  Copyright © 2020 NadiaAigayle. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import UIKit
import SwiftUI




struct Organizations {
    
    var name: String
    var id: String
    var img: String
    var website: String
    var location: String
    var orgDescription: String
    var favourite: Bool
    var email: String
    var hours: String
    var number: String
    var timeStamp: Timestamp
    
    init(name: String = "",
        id: String = "",
        img: String = "",
        website: String = "",
        location: String = "",
        orgDescription: String = "",
        favourite: Bool = false,
        email: String = "",
        hours: String = "",
        number: String = "",
        timeStamp: Timestamp = Timestamp()
        
        
        )
    
    {
        self.id = id
        self.email = email
        self.website = website
        self.number = number
        self.location = location
        self.name = name
        self.hours = hours
        self.orgDescription = orgDescription
        self.img = img
        self.favourite = favourite
        self.timeStamp = timeStamp

    }
    
    init(data: [String: Any]) {
        
        self.id = data["id"] as? String ?? ""
        
        self.email = data["email"] as? String ?? ""
        
        self.website = data["website"] as? String ?? ""
        
        self.number = data["number" ] as? String ?? ""
        
        self.location = data["location"] as? String ?? ""
        
        self.name = data["name"] as? String ?? ""
        
        self.hours = data["hours"] as? String ?? ""
        
        self.orgDescription = data["orgDescription"] as? String ?? ""
        
        self.img = data["img"] as? String ?? ""
        
        self.favourite = data["favourite"] as? Bool ?? false
        
        self.timeStamp = data["timeStamp"] as? Timestamp ?? Timestamp()
        
        
    
    }
    
    static func modelToData(organization: Organizations) -> [String: Any] {
        
        let data : [String: Any] = [
            "name" : organization.name,
            "id" : organization.id,
            "img" : organization.img,
            "website" : organization.website,
            "location" : organization.location,
            "orgDescription" : organization.orgDescription,
            "favourite" : organization.favourite,
            "email" : organization.email,
            "hours" : organization.hours,
            "number" : organization.number,
            "timeStamp": organization.timeStamp
            
        ]
        
        return data
    }
    

}
extension Organizations : Equatable {
    static func ==(lhs: Organizations, rhs: Organizations) -> Bool {
        return lhs.id == rhs.id
    }
}
