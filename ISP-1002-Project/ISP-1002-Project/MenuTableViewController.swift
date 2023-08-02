//
//  MenuTableViewController.swift
//  ISP-1002-Project
//
//  Created by Daphne Rivera on 2023-08-01.
//

import UIKit

class MenuTableViewController: UITableViewController, ItemViewControllerDelegate {
 

    var menuItems: [MenuItem] = []
    var orders = Orders.shared
    var order: Order?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide the ViewOrder button initially
                navigationItem.rightBarButtonItem = nil
        
        let menuItem1 = MenuItem(itemID: 1, title: "Burger", description: "Delicious beef burger", image: "burger")
        let menuItem2 = MenuItem(itemID: 2, title: "Pizza", description: "Freshly baked pizza with assorted toppings", image: "pizza")
        let menuItem3 = MenuItem(itemID: 3, title: "Fried Chicken", description: "Crispy, flavorful fried chicken.", image: "chicken")
        let menuItem4 = MenuItem(itemID: 4, title: "Sushi", description: "Exquisite sushi creations", image: "sushi")
        menuItems = [menuItem1, menuItem2, menuItem3, menuItem4]
        
       // self.tableView.dataSource = self
        //self.tableView.delegate = self

    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemCell", for: indexPath) as! MenuItemCell
        let menuItem = menuItems[indexPath.row]
        
        cell.titleTextView?.text = menuItem.title
        cell.descriptionTextView?.text = menuItem.description
        cell.itemImageView?.image = UIImage(named: menuItem.image)
    
        return cell
    }
   

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "ItemSegue", let indexPath = tableView.indexPathForSelectedRow {
                let selectedItem = menuItems[indexPath.row]

                if let destinationVC = segue.destination as? ItemViewController {
                    destinationVC.selectedItem = selectedItem
                    destinationVC.selectedItemTitle = selectedItem.title
                    destinationVC.delegate = self
                }
            }
            if segue.identifier == "ViewOrderSegue" {
                if let orderTableViewController = segue.destination as? OrderTableViewController {
                    orderTableViewController.order = orders.orderList.last
                }
            }
        }
        
     

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        headerView.backgroundColor = UIColor.lightGray
        
        let titleLabel = UILabel(frame: CGRect(x: 10, y: 0, width: tableView.frame.width - 20, height: 40))
        titleLabel.text = "All You Can Eat Menu"
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        headerView.addSubview(titleLabel)
        
        return headerView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    // Function to show the ViewOrder button
       func showViewOrderButton() {
           let viewOrderButton = UIBarButtonItem(title: "View Order", style: .plain, target: self, action: #selector(viewOrderButtonTapped))
           navigationItem.rightBarButtonItem = viewOrderButton
       }

       // Function to hide the ViewOrder button
       func hideViewOrderButton() {
           navigationItem.rightBarButtonItem = nil
       }

       // Action for the ViewOrder button
    @objc func viewOrderButtonTapped() {
           // Get the last order added to the list
           if let lastOrder = orders.orderList.last {
               // Assign the last order to the order property of the OrderTableViewController
               if let orderTableViewController = storyboard?.instantiateViewController(withIdentifier: "OrderTableViewController") as? OrderTableViewController {
                   orderTableViewController.order = lastOrder
                   print("Order trasnfered successfully:")
                   print("Menu Item: \(lastOrder.menuItem.title)")
                   print("Quantity: \(lastOrder.quantity)")

                   // Present the OrderTableViewController using navigation controller
                  navigationController?.pushViewController(orderTableViewController, animated: true)
               }
           } else {
               // Handle the case when there are no orders
               print("No orders to display.")
           }
       }
    
    func addToOrderButtonTapped() {
               showViewOrderButton()
           }
   
    @IBAction func unwindToMenuTableViewController(segue: UIStoryboardSegue) {
           // This is the unwind method that will be called when returning from ItemViewController.
           // Any necessary actions after returning from ItemViewController can be placed here.
       }
   

}
