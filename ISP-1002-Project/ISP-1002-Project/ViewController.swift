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
    var orders = Orders()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            
        
        let menuItem1 = MenuItem(itemID: 1, title: "Burger", description: "Delicious beef burger", image: "burger")
        let menuItem2 = MenuItem(itemID: 2, title: "Pizza", description: "Freshly baked pizza with assorted toppings", image: "pizza")
        let menuItem3 = MenuItem(itemID: 3, title: "Fried Chicken", description: "Crispy, flavorful fried chicken.", image: "chicken")
        let menuItem4 = MenuItem(itemID: 4, title: "Sushi", description: "Exquisite sushi creations", image: "sushi")
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
        
        cell.titleTextView.text = menuItem.title
        cell.descriptionTextView.text = menuItem.description
        cell.itemImageView.image = UIImage(named: menuItem.image)
    
        return cell
    }
   

  
        
        // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               if segue.identifier == "ItemSegue",
                  let navigationController = segue.destination as? UINavigationController,
                  let itemViewController = navigationController.topViewController as? ItemViewController,
                  let indexPath = table.indexPathForSelectedRow{
                   let selectedItem = menuItems[indexPath.row]
                   itemViewController.selectedItem = selectedItem
                   print("Selected item: \(selectedItem)") // Check if the selected item is correct
                   itemViewController.selectedItemTitle = selectedItem.title
                   print("Selected item title: \(itemViewController.selectedItemTitle)") // Check if the selected item title is set correctly

               }
           }
//
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        headerView.backgroundColor = UIColor.lightGray
        
        let titleLabel = UILabel(frame: CGRect(x: 10, y: 0, width: tableView.frame.width - 20, height: 40))
        titleLabel.text = "All You Can Eat Menu"
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        headerView.addSubview(titleLabel)
        
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
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


