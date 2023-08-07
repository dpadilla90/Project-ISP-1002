//
//  Orders.swift
//  ISP-1002-Project
//
//  Created by Daphne Rivera on 2023-06-29.
//

import Foundation
// Orders class
class Orders {
    var allOrders: [Order] = []

    func addOrder(_ order: Order) {
        allOrders.append(order)
    }
    
    // You can also add other methods as needed.
}
