//
//  FootyGameAnnotation.swift
//  FootyMaps
//
//  Created by Ben Makusha on 4/5/17.
//  Copyright © 2017 Ben Makusha. All rights reserved.
//

import Foundation
import MapKit

class FootyGameAnnotation: NSObject, MKAnnotation {
    var coordinate = CLLocationCoordinate2D()
    //var location: String!
    //var duration: Int
    var gameId: Int
    //var title: String?
    
    init(coordinate: CLLocationCoordinate2D, gameId: Int){
        self.coordinate = coordinate
        self.gameId = gameId
    }
}
