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

class ActivityDto: Decodable, Glossy {
    
    var name: String
    var description: String
    var image: UIImage?
    var lat: Double
    var lng: Double
    var locationName: String
    var date: String
    
    init?() {
        self.name = ""
        self.description = ""
        self.image = nil
        self.lat = 0.0
        self.lng = 0.0
        self.locationName = ""
        self.date = ""
    }
    
    init?(name: String?, description: String?, latitude: Double?, longitude: Double?, locationName: String?, date: String?) {
        self.name = name!
        self.description = description!
        self.image = nil
        self.lat = latitude!
        self.lng = longitude!
        self.locationName = locationName!
        self.date = date!
    }
    
    required init?(json: JSON) {
        self.name = ("name" <~~ json)!
        self.description = ("description" <~~ json)!
        self.lat = ("lat" <~~ json)!
        self.lng = ("lng" <~~ json)!
        self.locationName = ("locationName" <~~ json)!
        self.date = ("date" <~~ json)!
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "name" ~~> self.name,
            "description" ~~> self.description,
            "lat" ~~> self.lat,
            "lng" ~~> self.lng,
            "locationName" ~~> self.locationName,
            "date" ~~> self.date
            ])
    }
    
}
