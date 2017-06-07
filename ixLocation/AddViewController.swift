//
//  AddViewController.swift
//  ixLocation
//
//  Created by Nathan Justin on 6/5/17.
//  Copyright © 2017 Nathan Justin. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    var delegate: AddDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    
    @IBAction func saveAction(_ sender: Any) {
        
        if (nameTextField.text?.isEmpty)! || (descriptionTextView.text?.isEmpty)! {
            // Throw an error
            let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
            
            let alertController = UIAlertController(title: "Error", message: "Please enter some text", preferredStyle: .alert)
            
            // Now adding the default action to the alert controller
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            let newActivity = Activity(name: nameTextField.text, description: descriptionTextView.text)
            
            delegate?.didSaveActivity(activity: newActivity!) // Use delegate
            
            self.dismiss(animated: true, completion:  nil)
        }
    }
    
}
