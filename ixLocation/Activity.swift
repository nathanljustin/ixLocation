//
//  Activity.swift
//  ixLocation
//
//  Created by Nathan Justin on 6/6/17.
//  Copyright © 2017 Nathan Justin. All rights reserved.
//

import UIKit

class Activity {
    
    var name: String
    var description: String
    var image: UIImage?
    var location: GeoPoint
    
    init?() {
        self.name = ""
        self.description = ""
        self.image = nil
        self.location = GeoPoint(latitude: 0.0, longitude: 0.0)
    }
}
