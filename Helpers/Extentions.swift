//
//  Extentions.swift
//  WasteManagement
//
//  Created by Nadia Shalaby on 2020-04-03.
//  Copyright © 2020 NadiaAigayle. All rights reserved.
//

import UIKit
import Firebase

extension String {
    var isNotEmpty : Bool {
        return !isEmpty
    }
}

extension UIViewController {

    
    func simpleAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}


extension Date {
  
  init(year: Int,
       month: Int,
       day: Int,
       hour: Int = 0,
       minute: Int = 0,
       second: Int = 0,
       timeZone: TimeZone = TimeZone(abbreviation: "UTC")!) {
    var components = DateComponents()
    components.year = year
    components.month = month
    components.day = day
    components.hour = hour
    components.minute = minute
    components.second = second
    components.timeZone = timeZone
    self = Calendar.current.date(from: components)!
  }
  
  init(dateString: String) {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss zz"
    self = formatter.date(from: dateString)!
  }
  
}
