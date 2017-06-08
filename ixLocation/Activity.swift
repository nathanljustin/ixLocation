//
//  Activity.swift
//  ixLocation
//
//  Created by Nathan Justin on 6/6/17.
//  Copyright © 2017 Nathan Justin. All rights reserved.
//

import UIKit
import MapKit

class Activity {
    
    var name: String
    var description: String
    var image: UIImage?
    var location: MKMapItem
    
    init?(name: String?, description: String?, location: MKMapItem) {
        self.name = name!
        self.description = description!
        self.image = nil
        self.location = location
    }
}
