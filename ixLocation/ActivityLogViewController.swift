//
//  SecondViewController.swift
//  ixLocation
//
//  Created by Nathan Justin on 6/5/17.
//  Copyright © 2017 Nathan Justin. All rights reserved.
//

import UIKit

class ActivityLogViewController: UITableViewController, AddDelegate {

    var activities: [Activity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as! ActivityTableViewCell
        
        // Configure the cell...
        cell.nameLabel.text = activities[indexPath.row].name
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        cell.dateLabel.text = formatter.string(from: date)
        
        cell.locationLabel.text = activities[indexPath.row].location.name
        
        // Choose picture here...
        
        return cell as UITableViewCell
    }
    
    func didSaveActivity(activity: Activity) {
        activities.append(activity)
        self.tableView.reloadData() // will call table view functions again
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "activityDetailSegue" {
            let activityViewController = segue.destination as! ActivityViewController
            
            // Get indexPath of the cell selected
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPath(for: cell)
            
            // Pass that activity to ActivityDetailViewController
            activityViewController.activity = activities[(indexPath?.row)!]
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



