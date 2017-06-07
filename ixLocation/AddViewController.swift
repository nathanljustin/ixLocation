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
    
    //var delegate: AddDelegate?
    var newActivity: Activity = Activity()!
    var activities: [Activity]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if UserDefaults.standard.array(forKey: "activities") != nil{
            activities = UserDefaults.standard.array(forKey: "activities") as? [Activity]
        }
        else {
            activities = []
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.array(forKey: "activities") != nil{
            activities = UserDefaults.standard.array(forKey: "activities") as? [Activity]
        }
        else {
            activities = []
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
        //delegate?.didCancelActivity()
        dismiss(animated: true, completion: nil)
    }

    
    @IBAction func saveAction(_ sender: Any) {
        
        if nameTextField.text != nil && descriptionTextView.text != nil && imageView.image != nil {
            
            newActivity.name = nameTextField.text!
            newActivity.description = descriptionTextView.text
        
            // Will implement these once I know how to get user imput for these...
            newActivity.location = GeoPoint(latitude: 0.0, longitude: 0.0)
            newActivity.image = imageView.image
        
            activities.append(newActivity)
        
            UserDefaults.standard.set(activities, forKey: "activities")
        
            dismiss(animated: true, completion: nil)
        }
    }
    
}
