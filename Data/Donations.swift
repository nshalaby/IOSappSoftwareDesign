//
//  Donations.swift
//  WasteManagement
//
//  Created by Nadia Shalaby on 2020-03-25.
//  Copyright © 2020 NadiaAigayle. All rights reserved.
//

import Foundation
import Firebase
import UIKit
import SwiftUI
import CoreLocation

struct Donations {
    
    var name: String
    var id: String
    var organization: String
    var quantity: Int
    var timeStamp: Timestamp
    var img: String
    var isActive: Bool
    var type: String
    var orgName: String
    
    init(
        
        name: String,
        id: String,
        organization: String,
        quantity: Int = 0,
        timeStamp: Timestamp = Timestamp(),
        img: String,
        isActive: Bool,
        type: String,
        orgName: String
    
    ) {
        self.name = name
        self.id = id
        self.organization = organization
        self.quantity = quantity
        self.img = img
        self.isActive = isActive
        self.type = type
        self.timeStamp = timeStamp
        self.orgName = orgName
        
    }
    
    
    init(data: [String: Any]) {
    
    self.name = data["name"] as? String ?? ""
    
    self.id = data["id"] as? String ?? ""
    
    self.organization = data["organization"] as? String ?? ""
    
    self.quantity = data["quantity" ] as? Int ?? Int()
    
    self.timeStamp = data["timeStamp"] as? Timestamp ?? Timestamp()
    
    self.img = data["img"] as? String ?? ""
    
    self.isActive = data["isActive"] as? Bool ?? false
    
    self.type = data["type"] as? String ?? ""
        
    self.orgName = data["orgName"] as? String ?? ""
    
    
    
    }
    
    static func modelToData(donation: Donations) -> [String: Any] {
           
           let data : [String: Any] = [
               "name" : donation.name,
               "id" : donation.id,
               "organization" : donation.organization,
               "quantity" : donation.quantity,
               "timeStamp" : donation.timeStamp,
               "img" : donation.img,
               "isActive" : donation.isActive,
               "type" : donation.type,
               "orgName": donation.orgName
           ]
           
           return data
       }

    
    
    
    
    
}

extension Donations : Equatable {
    static func ==(lhs: Donations, rhs: Donations) -> Bool {
        return lhs.id == rhs.id
    }
}
