//
//  FootyGame.swift
//  FootyMaps
//
//  Created by Ben Makusha on 4/5/17.
//  Copyright © 2017 Ben Makusha. All rights reserved.
//

import Foundation

class FootyGame {
    private var _location: String!
    private var _hostName: String!
    private var _duration: Int!
    
    var location: String {
        return _location
    }
    
    var hostName: String {
        return _hostName
    }
    
    var duration: Int {
        return _duration
    }
    
    init(location: String, duration: Int) {
        self._location = location
        self._duration = duration
    }
}
