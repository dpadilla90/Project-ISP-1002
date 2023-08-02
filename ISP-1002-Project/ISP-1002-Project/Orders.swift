//
//  Orders.swift
//  ISP-1002-Project
//
//  Created by Daphne Rivera on 2023-06-29.
//

import Foundation
// Orders class
class Orders {
    static let shared = Orders() // Singleton instance
    
    var orderList: [Order] = []
    private init() {}
    func addOrder(order: Order) {
        orderList.append(order)
        print("Order added: \(order)")

    }
    
    func deleteOrder(order: Order) {
        if let index = orderList.firstIndex(of: order) {
            orderList.remove(at: index)
        }
    }
    
    func modifyOrder(oldOrder: Order, newOrder: Order) {
        if let index = orderList.firstIndex(of: oldOrder) {
            orderList[index] = newOrder
        }
    }
}
