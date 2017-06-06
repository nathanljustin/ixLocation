//
//  SettingsViewController.swift
//  ixLocation
//
//  Created by Nathan Justin on 6/5/17.
//  Copyright © 2017 Nathan Justin. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    @IBOutlet weak var profile: UITableViewCell!
    @IBOutlet weak var maps: UITableViewCell!
    @IBOutlet weak var name: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.string(forKey: "name") == nil {
            UserDefaults.standard.set("Set Your User Name!", forKey: "name")
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        name.text = UserDefaults.standard.string(forKey: "name")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 && indexPath.row == 1 {
            self.tabBarController?.selectedIndex = 0
        }
        
        if indexPath.section == 1 && indexPath.row == 1 {
            self.tabBarController?.selectedIndex = 1
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profileSegue" {
            if let profileVC = segue.destination as? ProfileSettingsViewController {
                profileVC.name = name.text
            }
        }
        
    }
    
}
