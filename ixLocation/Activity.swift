//
//  Activity.swift
//  ixLocation
//
//  Created by Nathan Justin on 6/6/17.
//  Copyright © 2017 Nathan Justin. All rights reserved.
//

import Realm

class Activity: RLMObject {
    dynamic var name = ""
    dynamic var descr = ""
    dynamic var lat = 0.0
    dynamic var lng = 0.0
    dynamic var locationName = ""
    dynamic var date = ""
}
