//
//  Order.swift
//  ISP-1002-Project
//
//  Created by Daphne Rivera on 2023-06-29.
//

import Foundation
// Order class
class Order {
    var items: [OrderItem]
    // Add other properties as needed, like orderDate, totalAmount, etc.

    init(items: [OrderItem]=[]) {
        self.items = items
    }
    
    // You can also add methods to compute the total amount, add an item, etc.
}

