//
//  Order.swift
//  ISP-1002-Project
//
//  Created by Daphne Rivera on 2023-06-29.
//

import Foundation
// Order class
class Order: NSObject, NSCoding {
    var items: [OrderItem]

    init(items: [OrderItem] = []) {
        self.items = items
    }

    // Conform to NSCoding
    required init?(coder aDecoder: NSCoder) {
        items = aDecoder.decodeObject(forKey: "items") as! [OrderItem]
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(items, forKey: "items")
    }
}
