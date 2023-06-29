//
//  Order.swift
//  ISP-1002-Project
//
//  Created by Daphne Rivera on 2023-06-29.
//

import Foundation
// Order class
class Order: Equatable {
    let menuItem: MenuItem
    var quantity: Int
    var specialInstructions: String
    
    init(menuItem: MenuItem, quantity: Int, specialInstructions: String) {
        self.menuItem = menuItem
        self.quantity = quantity
        self.specialInstructions = specialInstructions
    }
    
    static func == (lhs: Order, rhs: Order) -> Bool {
        return lhs.menuItem.itemID == rhs.menuItem.itemID
    }
}
