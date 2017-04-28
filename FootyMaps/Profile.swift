//
//  Profile.swift
//  FootyMaps
//
//  Created by Ben Makusha on 4/27/17.
//  Copyright © 2017 Ben Makusha. All rights reserved.
//

import Foundation
import Firebase

class Profile {
    private var _username: String!
    private var _favFootballer: String!
    private var _age: Int!
    private var _emailAddress: String!
    private var _postKey: String!
    private var _postedDate: String!
    private var _updateCredentials: FIRDatabaseReference!
    
    var username: String {
        return _username
    }
    
    var favFootballer: String {
        return _favFootballer
    }
    
    var age: Int {
        return _age
    }
    
    var emailAddress: String {
        return _emailAddress
    }
    
    var postKey: String {
        return _postKey
    }
    
    var postedDate: String {
        return _postedDate
    }
    
    init(postKey: String, postCreds: Dictionary<String, Any>) {
        self._postKey = postKey
        
        if let username = postCreds["username"] as? String {
            self._username = username
        }
        
        if let favFootballer = postCreds["favoriteFootballer"] as? String {
            self._favFootballer = favFootballer
        }
        
        if let age = postCreds["age"] as? Int {
            self._age = age
        }
        
        if let emailAddress = postCreds["email"] as? String {
            self._emailAddress = emailAddress
        }
        
        if let postedDate = postCreds["postedDate"] as? String {
            self._postedDate = postedDate
        }
        
        _updateCredentials = DataService.ds.REF_USER_CURRENT
    }

}
