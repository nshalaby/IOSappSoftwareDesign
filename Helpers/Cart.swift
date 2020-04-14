//
//  Cart.swift
//  WasteManagement
//
//  Created by Nadia Shalaby on 2020-04-02.
//  Copyright © 2020 NadiaAigayle. All rights reserved.
//

import Foundation

let Cart = _Cart()

//singleton class
final class _Cart {
    
    var cartItems = [Donations]()
    var totalItems = 0
    
    var numberOfItems: Int {
        var amount = 0
        for item in cartItems {
            let number = Int(item.quantity)
            amount += number
        }
        return amount
    }
    
    func addItemToCart(item: Donations) {
        
        cartItems.append(item)
        totalItems = (totalItems + item.quantity)
    }
    
    func removeItemFromCart(item: Donations) {
        
      if let index = cartItems.firstIndex(of: item) {
        cartItems.remove(at: index)
        totalItems = (totalItems - item.quantity)
        
            
        }
        
        
    }
    
    
    func clearCart() {
        
        cartItems.removeAll()
        totalItems = 0
        
    }
    

}
