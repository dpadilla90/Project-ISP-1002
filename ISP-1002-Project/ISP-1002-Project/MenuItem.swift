//
//  MenuItem.swift
//  ISP-1002-Project
//
//  Created by Daphne Rivera on 2023-06-29.
//

import Foundation
// MenuItem class
class MenuItem: NSObject, NSCoding {
    let itemID: Int
    let title: String
    let itemDescription: String
    let image: String
    
    init(itemID: Int, title: String, itemDescription: String, image: String) {
        self.itemID = itemID
        self.title = title
        self.itemDescription = itemDescription
        self.image = image
    }
    
    // Conform to NSCoding
    required init?(coder aDecoder: NSCoder) {
        itemID = aDecoder.decodeInteger(forKey: "itemID")
        title = aDecoder.decodeObject(forKey: "title") as! String
        itemDescription = aDecoder.decodeObject(forKey: "itemDescription") as! String
        image = aDecoder.decodeObject(forKey: "image") as! String
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(itemID, forKey: "itemID")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(itemDescription, forKey: "itemDescription")
        aCoder.encode(image, forKey: "image")
    }
}

