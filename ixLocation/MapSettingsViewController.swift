//
//  MapSettingsViewController.swift
//  ixLocation
//
//  Created by Nathan Justin on 6/6/17.
//  Copyright © 2017 Nathan Justin. All rights reserved.
//

import UIKit

class MapSettingsViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // First de-select all
        tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.accessoryType = .none
        tableView.cellForRow(at: IndexPath(row: 1, section: 0))?.accessoryType = .none
        tableView.cellForRow(at: IndexPath(row: 2, section: 0))?.accessoryType = .none
            
        // Determine which cell was chosen
        if let cell = tableView.cellForRow(at: indexPath) {
            if indexPath.row == 0 {
                UserDefaults.standard.set("standard", forKey: "mapType")
            }
                
            if indexPath.row == 1 {
                UserDefaults.standard.set("satelite", forKey: "mapType")
            }
                
            if indexPath.row == 2 {
                UserDefaults.standard.set("hybrid", forKey: "mapType")
            }
                
            cell.accessoryType = .checkmark
        }
    }
    
}
