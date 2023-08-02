//
//  OrderTableViewController.swift
//  ISP-1002-Project
//
//  Created by Daphne Rivera on 2023-08-01.
//
import UIKit

class OrderTableViewController: UITableViewController {
    var orders = Orders.shared
    var order: Order?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register the custom cell class for reuse
        tableView.register(OrderItemCell.self, forCellReuseIdentifier: "OrderItemCell")
    }
    
    // MARK: - UITableViewDataSource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of items in the order
        return order?.items.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the table view cell to display the item details
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderItemCell", for: indexPath) as! OrderItemCell
        if let item = order?.items[indexPath.row] {
            // Configure the cell with the item details (e.g., item title, quantity, etc.)
            cell.titleLabel.text = item.title
            cell.quantityLabel.text = "Quantity: \(item.quantity)"
            // Configure other custom cell properties as needed
        }
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

   

 
