//
//  ViewController.swift
//  ISP-1002-Project
//
//  Created by Daphne Rivera on 2023-07-15.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var table: UITableView!
    
    var menuItems: [MenuItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuItem1 = MenuItem(itemID: 1, title: "Burger", description: "Delicious beef burger", price: 10.99, image: "burger")
        let menuItem2 = MenuItem(itemID: 2, title: "Pizza", description: "Freshly baked pizza with assorted toppings", price: 12.99, image: "pizza")
        
        menuItems = [menuItem1, menuItem2]
        
        // Do any additional setup after loading the view.
    }
}

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


