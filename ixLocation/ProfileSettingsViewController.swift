//
//  ProfileSettingsViewController.swift
//  ixLocation
//
//  Created by Nathan Justin on 6/6/17.
//  Copyright © 2017 Nathan Justin. All rights reserved.
//

import UIKit

class ProfileSettingsViewController: UIViewController {
    
    var name: String?
    
    @IBOutlet weak var nameText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameText.placeholder = name
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func update(_ sender: Any) {
        name = nameText.text
        UserDefaults.standard.set(name, forKey: "name")
    }

}
