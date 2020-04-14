//
//  Users.swift
//  WasteManagement
//
//  Created by Nadia Shalaby on 2020-03-25.
//  Copyright © 2020 NadiaAigayle. All rights reserved.
//

import Foundation
import Firebase

struct User {
    
    var id: String
    var email: String
    var firstName: String
    var lastName: String
    
    init(id: String = "",
        email: String = "",
        firstName: String = "",
        lastName: String = "")
    
    {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName

    }

    init(data: [String: Any]) {
        id = data["id"] as? String ?? ""
        email = data["email"] as? String ?? ""
        firstName = data["firstName"] as? String ?? ""
        lastName = data["lastName"] as? String ?? ""
           
       }
    
    static func modelToData(user: User) -> [String: Any] {
        
        let data : [String: Any] = [
            "id" : user.id,
            "email" : user.email,
            "firstName" : user.firstName,
            "lastName": user.lastName
        ]
        
        return data
    }

    
}
