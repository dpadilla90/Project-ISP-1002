//
//  MenuTableViewController.swift
//  ISP-1002-Project
//
//  Created by Daphne Rivera on 2023-08-01.
//

import UIKit

class MenuTableViewController: UITableViewController, ItemViewControllerDelegate {
  
 
    @IBOutlet weak var viewOrderButton: UIBarButtonItem!
    
    var menuItems: [MenuItem] = []

    var order = Order()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewOrderButton.isHidden = true
        // Load the archived order if it exists
        if let archivedOrder = Order.loadOrder() {
            order = archivedOrder
            viewOrderButton.isHidden = (order.items.isEmpty) ? true : false
        }
        
        
        let menuItem1 = MenuItem(itemID: 1, title: "Burger", itemDescription: "Delicious beef burger", image: "burger")
        let menuItem2 = MenuItem(itemID: 2, title: "Pizza", itemDescription: "Freshly baked pizza with assorted toppings", image: "pizza")
        let menuItem3 = MenuItem(itemID: 3, title: "Fried Chicken", itemDescription: "Crispy, flavorful fried chicken.", image: "chicken")
        let menuItem4 = MenuItem(itemID: 4, title: "Sushi", itemDescription: "Exquisite sushi creations", image: "sushi")
        menuItems = [menuItem1, menuItem2, menuItem3, menuItem4]
        
       
        // Add app lifecycle observers
        NotificationCenter.default.addObserver(self, selector: #selector(appWillTerminate), name: UIApplication.willTerminateNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemCell", for: indexPath) as! MenuItemCell
        let menuItem = menuItems[indexPath.row]
        
        cell.titleTextView?.text = menuItem.title
        cell.descriptionTextView?.text = menuItem.itemDescription
        cell.itemImageView?.image = UIImage(named: menuItem.image)
    
        return cell
    }
   

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "ItemSegue",
               let indexPath = tableView.indexPathForSelectedRow,
               let destinationVC = segue.destination as? ItemViewController {
                destinationVC.menuItem = menuItems[indexPath.row]
                destinationVC.delegate = self 
            }
        // Check if it's the segue to OrderTableViewController
           else if segue.identifier == "ViewOrderSegue",
                   let destinationVC = segue.destination as? OrderTableViewController {
                   destinationVC.order = self.order
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

    
    func addToOrderButtonTapped() {
        viewOrderButton.isHidden = false
           }
    func itemViewController(_ controller: ItemViewController, didAddOrderItem orderItem: OrderItem) {
        order.items.append(orderItem)
        order.saveOrder()
    }
    @objc func appWillTerminate() {
          order.saveOrder()
      }

      @objc func appDidEnterBackground() {
          order.saveOrder()
      }

    
   
    @IBAction func unwindToMenuTableViewController(segue: UIStoryboardSegue) {
           // This is the unwind method that will be called when returning from ItemViewController.
        order.saveOrder()
       }
   

}
