//
//  ActivityViewController.swift
//  ixLocation
//
//  Created by Nathan Justin on 6/7/17.
//  Copyright © 2017 Nathan Justin. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {
    
    var activity: Activity? = nil
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var image: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameLabel.text = activity?.name
        descriptionLabel.text = activity?.description
        locationLabel.text = "default" //need to fill in
        image.image = activity?.image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
