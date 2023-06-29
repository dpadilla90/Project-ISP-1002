//
//  MenuItem.swift
//  ISP-1002-Project
//
//  Created by Daphne Rivera on 2023-06-29.
//

import Foundation
// MenuItem class
class MenuItem {
    let itemID: Int
    let title: String
    let description: String
    
    init(itemID: Int, title: String, description: String) {
        self.itemID = itemID
        self.title = title
        self.description = description
    }
}
