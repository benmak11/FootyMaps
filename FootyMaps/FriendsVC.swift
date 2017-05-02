//
//  FriendsVC.swift
//  FootyMaps
//
//  Created by Ben Makusha on 4/20/17.
//  Copyright © 2017 Ben Makusha. All rights reserved.
//

import UIKit
import Firebase

class FriendsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, CLLocationManagerDelegate{
    @IBOutlet weak var footballersTableView: UITableView!
    @IBOutlet weak var footballersSearchBar: UISearchBar!
    
    let footballerLocatioManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    let geoFire = GeoFire(firebaseRef: DB_BASE.child("users_locations"))
    var nearByFootballers = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        footballersTableView.delegate = self
        footballersTableView.dataSource = self
        
        footballersSearchBar.delegate = self
        footballersSearchBar.returnKeyType = UIReturnKeyType.done
        
        showUserLocation()
        findNearbyUsers()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return footballersTableView.dequeueReusableCell(withIdentifier: "FootballersCell") as! FootballersCell
    }
    
    func showUserLocation(){
        self.currentLocation = self.footballerLocatioManager.location
        Location.sharedInstance.latitube = self.currentLocation.coordinate.latitude
        Location.sharedInstance.longitude = self.currentLocation.coordinate.longitude
        let locLat = Location.sharedInstance.latitube
        let locLong = Location.sharedInstance.longitude
        
        let userLocation = ["location": ["latitude": locLat,
                                         "longitude": locLong]]
        let uid = FIRAuth.auth()!.currentUser!.uid
        DataService.ds.addUserLocation(uid: uid, userLocation: userLocation)
        print("Ben ---- Saved location")
    }
    
    func findNearbyUsers() {

        let circleQuery = geoFire?.query(at: currentLocation, withRadius: 5)
        
        _ = circleQuery!.observe(.keyEntered, with: { (key, location) in
            
            if !self.nearByFootballers.contains(key!) && key! != FIRAuth.auth()!.currentUser!.uid {
                self.nearByFootballers.append(key!)
            }
            
        })
        
        //Execute this code once GeoFire completes the query!
        circleQuery?.observeReady({
            
            for _ in self.nearByFootballers {
                
                DataService.ds.REF_USERS.observe(.value, with: { snapshot in
                    let value = snapshot.value as? NSDictionary
                    print("BEN: --- \(String(describing: value))")
                })
            }
            
        })

    }
    
    func updateUserLocation() {
        let userID = FIRAuth.auth()!.currentUser!.uid
        print("BEN --- Current user ID: \(userID)")
        geoFire!.setLocation(currentLocation, forKey: userID){ (error) in
            if(error != nil){
                print("BEN: --- An error occured: \(String(describing: error))")
            } else {
                print("Ben ---- Saved location")
            }
        }
    }

}
