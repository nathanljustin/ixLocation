//
//  AddViewController.swift
//  ixLocation
//
//  Created by Nathan Justin on 6/5/17.
//  Copyright © 2017 Nathan Justin. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var locationTextField: UITextField!
    
    var delegate: AddDelegate?
    
    var matchingItem: MKMapItem?
    var testing: Int = 0
    
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
            
            if matchingItem == nil {
                // Throw an error
                let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
                
                let alertController = UIAlertController(title: "Error", message: "No location matches found.", preferredStyle: .alert)
                
                // Now adding the default action to the alert controller
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
                
                return
            }
            
            let geo = GeoPoint(latitude: (matchingItem!.placemark.location?.coordinate.latitude)!, longitude: (matchingItem!.placemark.location?.coordinate.longitude)!)
            
            let newActivity = Activity(name: nameTextField.text, description: descriptionTextView.text, location: geo, locationName: matchingItem?.name)
            
            Alamofire.request("https://ixlocation-689b0.firebaseio.com/activities.json", method: .post, parameters: newActivity?.toJSON(), encoding: JSONEncoding.default).responseJSON { response in
                
                switch response.result {
                case .success(let _):
                    self.delegate?.didSaveActivity(activity: newActivity!)
                    self.dismiss(animated: true, completion: nil)
                case .failure: break
                    // Failure... handle error
                }
                
            }
            
            self.dismiss(animated: true, completion:  nil)
        }
    }
    
    
    @IBAction func searchAction(_ sender: Any) {
        if locationTextField.text == "" {
            let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
            
            let alertController = UIAlertController(title: "Error", message: "Please enter a location.", preferredStyle: .alert)
            
            // Now adding the default action to the alert controller
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            return
        }
        else {
            getLocation()
        }
    }
    
    func getLocation() {
        
        let searchBarText = locationTextField.text
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBarText
        let search = MKLocalSearch(request: request)
        
        search.start(completionHandler: {(response, error) in
            if error != nil {
                print("Error occured in search: \(error!.localizedDescription)")
            }
            else if response!.mapItems.count == 0 {
                let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
                
                let alertController = UIAlertController(title: "Error", message: "No location matches found.", preferredStyle: .alert)
                
                // Now adding the default action to the alert controller
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
                
                return
            }
            else {
                print("Matches found")
                
                self.matchingItem = response!.mapItems[0]
                print("Matching item = \(String(describing: self.matchingItem))")
            }
        })
 
    }
}
