//
//  OrderTableViewController.swift
//  ISP-1002-Project
//

import UIKit

/**
 `OrderTableViewController` manages the display of a list of ordered items in a table format.
 
 This class provides functionality for viewing items in an order, optionally editing the order
 (e.g., removing items), and visualizing order details.
 */
class OrderTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    
    // MARK: - Properties

    /// Represents the current order with a list of items.
    var order: Order?
    
    // MARK: - View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        // If the order is nil, initialize a new empty order
        if order == nil {
            order = Order()
        }

        // Set the right bar button item to the built-in edit button
        navigationItem.rightBarButtonItem = self.editButtonItem

        // Print the number of items in the current order for debugging purposes
        print("Order items count: \(order?.items.count ?? 0)")
        amountLabel.text = "1"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableview.reloadData()
        
    }
    
    
    // Customizing the edit button's title
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if editing {
            self.editButtonItem.title = "Done"
        } else {
            self.editButtonItem.title = "Edit"
        }
    }

    // MARK: - UITableViewDataSource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of items in the order
        return order?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue an order item cell and populate its labels with the relevant order item data
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderItemCell", for: indexPath) as! OrderItemCell
        if let orderItem = order?.items[indexPath.row] {
            cell.titleLabel?.text = orderItem.menuItem.title
            cell.quantityLabel?.text = String(orderItem.quantity)
        }
        return cell
    }
    
    // Allow deletion of order items, updating both the data source and the UI
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            order?.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // Provide a title for the header section of the table view
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Order Details"
    }
}

 
