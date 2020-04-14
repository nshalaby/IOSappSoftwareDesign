//
//  Facts.swift
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


struct Facts {
    
    var id: String
    var question: String
    var img: String
    var answer: String
    
    init(data: [String: Any]) {
    
    
    
    self.id = data["id"] as? String ?? ""
    
    self.question = data["question"] as? String ?? ""
    
    self.img = data["img" ] as? String ?? ""
    
    self.answer = data["answer"] as? String ?? ""
    
    
    
    }
    
    
    
    
    
}

