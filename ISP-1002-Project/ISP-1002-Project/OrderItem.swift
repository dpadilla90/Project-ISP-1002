//
//  File.swift
//  ISP-1002-Project
//
//  Created by Daphne Rivera on 2023-08-01.
//

import Foundation
// Define the OrderItem struct to represent an item in the order
class OrderItem: NSObject, NSCoding {
    var menuItem: MenuItem
    var quantity: Int
    var specialInstructions: String

    init(menuItem: MenuItem, quantity: Int, specialInstructions: String) {
        self.menuItem = menuItem
        self.quantity = quantity
        self.specialInstructions = specialInstructions
    }

    // Conform to NSCoding
    required init?(coder aDecoder: NSCoder) {
        menuItem = aDecoder.decodeObject(forKey: "menuItem") as! MenuItem
        quantity = aDecoder.decodeInteger(forKey: "quantity")
        specialInstructions = aDecoder.decodeObject(forKey: "specialInstructions") as! String
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(menuItem, forKey: "menuItem")
        aCoder.encode(quantity, forKey: "quantity")
        aCoder.encode(specialInstructions, forKey: "specialInstructions")
    }
}
