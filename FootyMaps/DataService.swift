//
//  DataService.swift
//  FootyMaps
//
//  Created by Ben Makusha on 4/4/17.
//  Copyright © 2017 Ben Makusha. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import SwiftKeychainWrapper

let DB_BASE = FIRDatabase.database().reference()
let STORAGE_BASE = FIRStorage.storage().reference()
let GeoFire_REF = FIRDatabase.database().reference()

class DataService{
    
    // MARK: Created the singleton
    static let ds = DataService()
    
    // MARK: DB References
    private var _REF_BASE = DB_BASE
    private var _REF_GAME_FEED = DB_BASE.child("games")
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_USERS_LOCATION = DB_BASE.child("users_locations")
    
    // MARK: Geofire instances to be used and marked in Database
    
    // MARK: Storage References
    // place storage references here if you need them
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_GAME_FEED: FIRDatabaseReference {
        return _REF_GAME_FEED
    }
    
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    
    var REF_USERS_LOCATION: FIRDatabaseReference {
        return _REF_USERS_LOCATION
    }
    
    var REF_USER_CURRENT: FIRDatabaseReference{
        let uid = KeychainWrapper.standard.string(forKey: KEY_UID)
        let user = REF_USERS.child(uid!)
        return user
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func addUserLocation(uid: String, userLocation: Dictionary<String, Any>){
        REF_USERS_LOCATION.child(uid).updateChildValues(userLocation)
    }
}
