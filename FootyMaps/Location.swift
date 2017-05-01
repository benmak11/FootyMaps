//
//  Location.swift
//  FootyMaps
//
//  Created by Ben Makusha on 5/1/17.
//  Copyright © 2017 Ben Makusha. All rights reserved.
//

import CoreLocation

class Location{
    static var sharedInstance = Location()
    private init() {}
    
    var latitube: Double!
    var longitude: Double!
}
