//
//  AddViewController.swift
//  ixLocation
//
//  Created by Nathan Justin on 6/5/17.
//  Copyright © 2017 Nathan Justin. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    
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
        dismiss(animated: true, completion: nil)
    }
    
    
}
