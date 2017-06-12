//
//  SecondViewController.swift
//  ixLocation
//
//  Created by Nathan Justin on 6/5/17.
//  Copyright © 2017 Nathan Justin. All rights reserved.
//

import UIKit
import Gloss
import Alamofire
import Realm

class ActivityLogViewController: UITableViewController, AddDelegate {

    var activities: RLMResults<Activity> {
        get {
            return Activity.allObjects() as! RLMResults<Activity>
        }
    }
    //var activities: [Activity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*
        Alamofire.request("https://ixlocation-689b0.firebaseio.com/activities.json").responseJSON { response in
            //print(response.request)  // original URL request
            //print(response.response) // HTTP URL response
            //print(response.data)     // server data
            //print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
                
                if let response = JSON as? NSDictionary {
                
                for (key, value) in response {
                    let activity = Activity()
                    
                    if let actDictionary = value as? [String : AnyObject] {
                        
                        activity?.name = actDictionary["name"] as! String
                        activity?.description = actDictionary["description"] as! String
                        activity?.locationName = actDictionary["locationName"] as! String
                        activity?.date = actDictionary["date"] as! String
                        
                        if let geoPointDictionary = actDictionary["location"] as? [String: AnyObject] {
                            let location = GeoPoint()
                            location.lat = (geoPointDictionary["lat"] as? Double)!
                            location.lng = (geoPointDictionary["lng"] as? Double)!
                            activity?.location = location
                        }

                    }
                    self.activities.append(activity!)
                }
                
                self.tableView.reloadData()
            }
            }
        }
 */
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(activities.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as! ActivityTableViewCell
        
        // Configure the cell...
        cell.nameLabel.text = activities[UInt(indexPath.row)].name
        
        cell.dateLabel.text = activities[UInt(indexPath.row)].date
        
        cell.locationLabel.text = activities[UInt(indexPath.row)].locationName
        
        // Choose picture here...
        
        return cell as UITableViewCell
    }
    
    func didSaveActivity(activity: Activity) {
        //activities.append(activity)
        self.tableView.reloadData() // will call table view functions again
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "activityDetailSegue" {
            let activityViewController = segue.destination as! ActivityViewController
            
            // Get indexPath of the cell selected
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPath(for: cell)
            
            // Pass that activity to ActivityDetailViewController
            activityViewController.activity = activities[UInt((indexPath?.row)!)]
        }
        if segue.identifier == "addSegue" {
            let navigationViewController = segue.destination as! UINavigationController
            
            let addViewController = navigationViewController.topViewController as! AddViewController
            
            addViewController.delegate = self
        }
    }
    
}

class ActivityTableViewCell: UITableViewCell {
    
    //@IBOutlet weak var imageCellView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
}



