//
//  OrderTableViewController.swift
//  ISP-1002-Project
//
//  Created by Daphne Rivera on 2023-08-01.
//
import UIKit

class OrderTableViewController: UITableViewController {
    var order: Order?
    var orders: [Order] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Check if the order was created successfully
        if let lastOrder = order {
              print("Order recieved successfully:")
              print("Menu Item: \(lastOrder.menuItem.title)")
              print("Quantity: \(lastOrder.quantity)")
              print("Special Instructions: \(lastOrder.specialInstructions)")
          } else {
              print("Failed to create the order.")
          }
        // Register the custom cell class for reuse
        tableView.register(OrderItemCell.self, forCellReuseIdentifier: "OrderItemCell")
    }
    
    // MARK: - UITableViewDataSource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of items in the order
        return orders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the table view cell to display the item details
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderItemCell", for: indexPath) as! OrderItemCell
            let item = orders[indexPath.row]
            // Configure the cell with the item details (e.g., item title, quantity, etc.)
            cell.titleLabel?.text = item.menuItem.title
            cell.quantityLabel?.text = "Quantity: \(item.quantity)"
            
        
        return cell
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Return the section header title (if needed)
        return "Order Details"
    }
}

   

 
