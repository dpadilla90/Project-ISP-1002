//
//  OrderTableViewController.swift
//  ISP-1002-Project
//
//  Created by Daphne Rivera on 2023-08-01.
//
import UIKit

class OrderTableViewController: UITableViewController {
    
 
 
   
    var order: Order?


    
    override func viewDidLoad() {
        super.viewDidLoad()
        if order == nil {
            order = Order()
        }

        navigationItem.rightBarButtonItem = self.editButtonItem
        print("Order items count: \(order?.items.count ?? 0)")
        
        
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if editing {
            self.editButtonItem.title = "Done"
        } else {
            self.editButtonItem.title = "Edit"
        }
    }

    // MARK: - UITableViewDataSource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of items in the order
        return order?.items.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "OrderItemCell", for: indexPath) as! OrderItemCell
           if let orderItem = order?.items[indexPath.row] {
               cell.titleLabel?.text = orderItem.menuItem.title
               cell.quantityLabel?.text = String(orderItem.quantity)
           }
           return cell
       }
    
    // (Optional) if you want to allow deletion of order items
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                order?.items.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
        

            }
        }
    
    

    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Return the section header title (if needed)
        return "Order Details"
    }
}

   

 
