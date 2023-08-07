//
//  ItemViewController.swift
//  ISP-1002-Project
//
//  Created by Daphne Rivera on 2023-07-16.
//

import UIKit

/**
 A protocol that defines delegate methods to communicate actions
 related to order item manipulations in `ItemViewController`.
 */
protocol ItemViewControllerDelegate: AnyObject {
    /// A method to inform that the "Add to Order" button was tapped.
    func addToOrderButtonTapped()
    
    /**
     A method to communicate the selected order item and its details.
     
     - Parameters:
        - controller: The `ItemViewController` where the order item was selected.
        - orderItem: The order item and its associated details.
     */
    func itemViewController(_ controller: ItemViewController, didAddOrderItem orderItem: OrderItem)
}

/**
 `ItemViewController` presents detailed information about a selected menu item
 and allows users to specify quantity and special instructions for their order.
 */
class ItemViewController: UIViewController {
    
    // MARK: - Properties
    
    /// Delegate to communicate user actions to the main menu.
    weak var delegate: ItemViewControllerDelegate?
    
    /// Outlets
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var specialInstructionsTextView: UITextView!
    @IBOutlet weak var addToOrderButton: UIButton!
    
    /// The selected quantity of the menu item.
    var selectedQuantity: Int = 1 {
        didSet {
            quantityLabel.text = "\(selectedQuantity)"
        }
    }
    
    /// The menu item being viewed.
    var menuItem: MenuItem!
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup navigation bar
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = false
        
        // Set the navigation item title based on the selected menu item
        navigationItem.title = menuItem.title
        
        // Configure the initial quantity and stepper values
        selectedQuantity = 1
        stepper.minimumValue = 1
        stepper.maximumValue = 10
        
        // Add a custom back button to the navigation bar
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        
        // Setup the special instructions text view
        specialInstructionsTextView.text = "Special Instructions"
        specialInstructionsTextView.textColor = UIColor.lightGray
        specialInstructionsTextView.delegate = self
    }
    
    // MARK: - Actions
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        // Update the quantity label as stepper value changes
        selectedQuantity = Int(sender.value)
    }
    
    @objc func backButtonTapped() {
        // Navigate back to the previous screen when back button is tapped
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addToOderButton(_ sender: Any) {
        // Create an order item and delegate its addition to the main menu
        let orderItem = OrderItem(menuItem: menuItem, quantity: selectedQuantity, specialInstructions: specialInstructionsTextView.text)
        
        delegate?.itemViewController(self, didAddOrderItem: orderItem)
        
        // Inform the delegate that the "Add to Order" button was tapped
        delegate?.addToOrderButtonTapped()
        
        // Navigate back to the MenuTableViewController
        performSegue(withIdentifier: "unwindToMenuTableViewController", sender: self)
    }
}

// MARK: - UITextViewDelegate

extension ItemViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        // Clear the placeholder text when editing begins
        if textView.text == "Special Instructions" {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        // Reset the placeholder text if the text view is empty after editing
        if textView.text.isEmpty {
            textView.text = "Special Instructions"
            textView.textColor = UIColor.lightGray
        }
    }
}
