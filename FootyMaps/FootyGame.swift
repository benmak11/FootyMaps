//
//  FootyGame.swift
//  FootyMaps
//
//  Created by Ben Makusha on 4/5/17.
//  Copyright © 2017 Ben Makusha. All rights reserved.
//

import Foundation
import Firebase

class FootyGame {
    private var _location: String!
    private var _duration: Int!
    private var _startTime: String!
    private var _postKey: String!
    private var _postedDate: String!
    private var _postRef: FIRDatabaseReference!
    
    var location: String {
        return _location
    }
    
    var duration: Int {
        return _duration
    }
    
    var startTime: String {
        return _startTime
    }
    var postKey: String {
        return _postKey
    }
    
    var postedDate: String {
        return _postedDate
    }
    
    init(location: String, duration: Int) {
        self._location = location
        self._duration = duration
    }
    
    init(postKey: String, postData: Dictionary<String, Any>) {
        self._postKey = postKey
        
        if let location = postData["location"] as? String {
            self._location = location
        }
        
        if let gameDuration = postData["gameDuration"] as? Int {
            self._duration = gameDuration
        }
        
        if let startTime = postData["startTime"] as? String {
            self._startTime = startTime
        }
        
        if let postedDate = postData["postedDate"] as? String {
            self._postedDate = postedDate
        }
        
        _postRef = DataService.ds.REF_GAME_FEED.child(_postKey)
    }

}
