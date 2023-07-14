//
//  Orders.swift
//  ISP-1002-Project
//
//  Created by Daphne Rivera on 2023-06-29.
//

import Foundation
// Orders class
class Orders {
    var orderList: [Order] = []
    
    func addOrder(order: Order) {
        orderList.append(order)
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