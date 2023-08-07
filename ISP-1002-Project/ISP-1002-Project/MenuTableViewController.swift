//
//  MenuTableViewController.swift
//  ISP-1002-Project
//
//  Created by Daphne Rivera on 2023-08-01.
//

import UIKit

/**
 `MenuTableViewController` is responsible for presenting a list of available menu items.
 Users can select items from this menu to view their details and add them to their order.
 */
class MenuTableViewController: UITableViewController, ItemViewControllerDelegate {
    
    // MARK: - Properties

    /// Outlets
    @IBOutlet weak var viewOrderButton: UIBarButtonItem!

    /// An array containing all menu items available.
    var menuItems: [MenuItem] = []

    /// The current order.
    var order = Order()
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initially hide the view order button.
        viewOrderButton.isHidden = true
        
        // Load the archived order if it exists.
        if let archivedOrder = Order.loadOrder() {
            order = archivedOrder
            viewOrderButton.isHidden = (order.items.isEmpty) ? true : false
        }
        
        // Sample menu items.
        let menuItem1 = MenuItem(itemID: 1, title: "Burger", itemDescription: "Delicious beef burger", image: "burger")
        let menuItem2 = MenuItem(itemID: 2, title: "Pizza", itemDescription: "Freshly baked pizza with assorted toppings", image: "pizza")
        let menuItem3 = MenuItem(itemID: 3, title: "Fried Chicken", itemDescription: "Crispy, flavorful fried chicken.", image: "chicken")
        let menuItem4 = MenuItem(itemID: 4, title: "Sushi", itemDescription: "Exquisite sushi creations", image: "sushi")
        menuItems = [menuItem1, menuItem2, menuItem3, menuItem4]
        
        // Add app lifecycle observers.
        NotificationCenter.default.addObserver(self, selector: #selector(appWillTerminate), name: UIApplication.willTerminateNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of menu items.
        return menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell with the corresponding menu item.
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemCell", for: indexPath) as! MenuItemCell
        let menuItem = menuItems[indexPath.row]
        
        cell.titleTextView?.text = menuItem.title
        cell.descriptionTextView?.text = menuItem.itemDescription
        cell.itemImageView?.image = UIImage(named: menuItem.image)
    
        return cell
    }
   
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Set the destination VC's properties based on which segue is performed.
        if segue.identifier == "ItemSegue",
           let indexPath = tableView.indexPathForSelectedRow,
           let destinationVC = segue.destination as? ItemViewController {
            destinationVC.menuItem = menuItems[indexPath.row]
            destinationVC.delegate = self
        } else if segue.identifier == "ViewOrderSegue",
                  let destinationVC = segue.destination as? OrderTableViewController {
            destinationVC.order = self.order
        }
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Set a custom height for the rows.
        return 100
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Set a custom header view for the section.
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
        // Set a custom height for the section header.
        return 40
    }
    
    // MARK: - ItemViewControllerDelegate
    
    func addToOrderButtonTapped() {
        // Show the order button when an item is added to the order.
        viewOrderButton.isHidden = false
    }
    
    func itemViewController(_ controller: ItemViewController, didAddOrderItem orderItem: OrderItem) {
        // Add the selected item to the order and save the order.
        order.items.append(orderItem)
        order.saveOrder()
    }
    
    // MARK: - App Lifecycle Handlers
    
    @objc func appWillTerminate() {
        // Save the order when the app is about to terminate.
        order.saveOrder()
    }

    @objc func appDidEnterBackground() {
        // Save the order when the app goes to the background.
        order.saveOrder()
    }
    
    // MARK: - Actions
    
    @IBAction func unwindToMenuTableViewController(segue: UIStoryboardSegue) {
        // Save the order after returning from another view controller.
        order.saveOrder()
    }
}
