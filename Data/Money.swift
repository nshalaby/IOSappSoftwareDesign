//
//  Money.swift
//  WasteManagement
//
//  Created by Nadia Shalaby on 2020-04-02.
//  Copyright © 2020 NadiaAigayle. All rights reserved.
//

import Foundation
import Firebase
import UIKit
import SwiftUI
import CoreLocation


struct Money {
    
    
    var id: String
    var organization: String
    var img: String
    var website: String
    
    init(data: [String: Any]) {
    
    
    
    self.id = data["id"] as? String ?? ""
    
    self.organization = data["organization"] as? String ?? ""
    
    self.img = data["img" ] as? String ?? ""
    
    self.website = data["website"] as? String ?? ""
    
    
    
    }
    
    
    
    
    
}
