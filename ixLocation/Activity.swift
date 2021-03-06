//
//  Activity.swift
//  ixLocation
//
//  Created by Nathan Justin on 6/6/17.
//  Copyright © 2017 Nathan Justin. All rights reserved.
//

import UIKit
import MapKit
import Gloss

class Activity: Decodable, Glossy {
    
    var name: String
    var description: String
    var image: UIImage?
    var location: GeoPoint
    var locationName: String
    
    init?() {
        self.name = ""
        self.description = ""
        self.image = nil
        self.location = GeoPoint(latitude: 0.0, longitude: 0.0)
        self.locationName = ""
    }
    
    init?(name: String?, description: String?, location: GeoPoint, locationName: String?) {
        self.name = name!
        self.description = description!
        self.image = nil
        self.location = location
        self.locationName = locationName!
    }
    
    required init?(json: JSON) {
        self.name = ("name" <~~ json)!
        self.description = ("description" <~~ json)!
        self.location = ("location" <~~ json)!
        self.locationName = ("locationName" <~~ json)!
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "name" ~~> self.name,
            "description" ~~> self.description,
            "location" ~~> self.location,
            "locationName" ~~> self.locationName
            ])
    }
    
}
