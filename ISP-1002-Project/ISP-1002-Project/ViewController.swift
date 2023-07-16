//
//  ViewController.swift
//  ISP-1002-Project
//
//  Created by Daphne Rivera on 2023-07-15.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var table: UITableView!
    
    var menuItems: [MenuItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuItem1 = MenuItem(itemID: 1, title: "Burger", description: "Delicious beef burger", image: "burger")
        let menuItem2 = MenuItem(itemID: 2, title: "Pizza", description: "Freshly baked pizza with assorted toppings", image: "pizza")
        let menuItem3 = MenuItem(itemID: 2, title: "Fried Chicken", description: "Crispy, flavorful fried chicken.", image: "chicken")
        let menuItem4 = MenuItem(itemID: 2, title: "Sushi", description: "Exquisite sushi creations", image: "sushi")
        menuItems = [menuItem1, menuItem2, menuItem3, menuItem4]
        
        table.dataSource = self
        table.delegate = self
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemCell", for: indexPath) as! MenuItemCell
        let menuItem = menuItems[indexPath.row]
        
        cell.titleLabel.text = menuItem.title
        cell.descriptionLabel.text = menuItem.description
        cell.itemImageView.image = UIImage(named: menuItem.image)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 140
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


