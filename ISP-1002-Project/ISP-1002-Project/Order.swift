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
extension Order {
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("order").appendingPathExtension("plist")

    func saveOrder() {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
            try data.write(to: Order.archiveURL)
        } catch {
            print("Couldn't save order")
        }
    }

    static func loadOrder() -> Order? {
        guard let codedData = try? Data(contentsOf: archiveURL) else { return nil }

        do {
            let object = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(codedData) as? Order
            return object
        } catch {
            print("Couldn't read order")
            return nil
        }
    }
}
