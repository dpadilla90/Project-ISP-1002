//
//  ItemViewController.swift
//  ISP-1002-Project
//
//  Created by Daphne Rivera on 2023-07-16.
//

import UIKit

protocol ItemViewControllerDelegate: AnyObject {
    func addToOrderButtonTapped()
    func itemViewController(_ controller: ItemViewController, didAddOrderItem orderItem: OrderItem)
}


class ItemViewController: UIViewController {
  
    weak var delegate: ItemViewControllerDelegate?
 

    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var specialInstructionsTextView: UITextView!
    @IBOutlet weak var addToOrderButton: UIButton!
    
    var selectedQuantity: Int = 1 {
        didSet {
            quantityLabel.text = "\(selectedQuantity)"
        }
    }
    var menuItem: MenuItem!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = false

        // Set the navigation item title
        navigationItem.title = menuItem.title
        
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
        
       
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
           selectedQuantity = Int(sender.value)
       }
    
    @objc func backButtonTapped() {
        // Handle the back button action here
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addToOderButton(_ sender: Any) {
      
        let orderItem = OrderItem(menuItem: menuItem, quantity: selectedQuantity, specialInstructions: specialInstructionsTextView.text)
        delegate?.itemViewController(self, didAddOrderItem: orderItem)
        
        
        
        // Inform the delegate (MenuTableViewController) that the addToOrderButton is tapped
            delegate?.addToOrderButtonTapped()
        
        // Perform the unwind segue to return to the MenuTableViewController
        performSegue(withIdentifier: "unwindToMenuTableViewController", sender: self)
    }
   
   
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


