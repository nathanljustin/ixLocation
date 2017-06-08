//
//  AddViewController.swift
//  ixLocation
//
//  Created by Nathan Justin on 6/5/17.
//  Copyright © 2017 Nathan Justin. All rights reserved.
//

import UIKit
import MapKit

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var locationTextField: UITextField!
    
    var delegate: AddDelegate?
    
    var matchingItems:[MKMapItem] = []
    
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
            
            // Get GeoPoint of location suggested
            matchingItems = getLocation()
            if matchingItems.count == 0 {
                // Throw an error
                let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
                
                let alertController = UIAlertController(title: "Error", message: "No location matches found.", preferredStyle: .alert)
                
                // Now adding the default action to the alert controller
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
                
                return
            }
            
            let mapItem = matchingItems[0]
            
            let newActivity = Activity(name: nameTextField.text, description: descriptionTextView.text, location: mapItem)
            
            delegate?.didSaveActivity(activity: newActivity!)
            
            self.dismiss(animated: true, completion:  nil)
        }
    }
    
    func getLocation() -> [MKMapItem] {
        
        matchingItems.removeAll()
        let searchBarText = locationTextField.text
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBarText
        let search = MKLocalSearch(request: request)
        
        search.start(completionHandler: {(response, error) in
            if error != nil {
                print("Error occured in search: \(error!.localizedDescription)")
            } else if response!.mapItems.count == 0 {
                print("No matches found")
            } else {
                print("Matches found")
                
                for item in response!.mapItems {
                    print("Name = \(String(describing: item.name))")
                    //print("Phone = \(item.phoneNumber)")
                    
                    self.matchingItems.append(item as MKMapItem)
                }
            }
        })
        
         print("Matching items = \(self.matchingItems.count)")
        
        return matchingItems
    }
}
