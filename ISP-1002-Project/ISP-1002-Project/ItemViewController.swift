//
//  ItemViewController.swift
//  ISP-1002-Project
//
//  Created by Daphne Rivera on 2023-07-16.
//

import UIKit

class ItemViewController: UIViewController {
    
    let orders = Orders()

    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var specialInstructionsTextView: UITextView!
    @IBOutlet weak var addToOrderButton: UIButton!
    
    var selectedQuantity: Int = 1 {
        didSet {
            quantityLabel.text = "\(selectedQuantity)"
        }
    }
    var selectedItem: MenuItem?
    var selectedItemTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = false

        // Set the navigation item title
        navigationItem.title = selectedItemTitle
        
        // Configure the initial quantity value
        selectedQuantity = 1
        stepper.minimumValue = 1
        stepper.maximumValue = 10
        
        // Add a back button to the navigation bar
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        
        // Set up the special instructions text view
        specialInstructionsTextView.text = "Special Instructions"
        specialInstructionsTextView.textColor = UIColor.lightGray
        specialInstructionsTextView.delegate = self
        
        // Add action for the "Add to Order" button
        addToOrderButton.addTarget(self, action: #selector(addToOrderButtonTapped), for: .touchUpInside)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        selectedQuantity = Int(sender.value)
    }
    
    @objc func backButtonTapped() {
        // Handle the back button action here
        navigationController?.popViewController(animated: true)
    }
    
    @objc func addToOrderButtonTapped() {
        guard let selectedItem = selectedItem else {
               // Handle the case when no item is selected
               return
           }
        // Get the selected quantity and special instructions
        let instructions = specialInstructionsTextView.text ?? ""
        
        // Perform actions to add the item to the order using the quantity and instructions
        // You can access the data model or call appropriate methods to handle the order
        
        let order = Order(menuItem: selectedItem, quantity: selectedQuantity, specialInstructions: instructions)
           orders.addOrder(order: order)

        
        // Perform any necessary navigation or UI updates after adding the item to the order
    }
    
    // Rest of your implementation
}


extension ItemViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Special Instructions" {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Special Instructions"
            textView.textColor = UIColor.lightGray
        }
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

