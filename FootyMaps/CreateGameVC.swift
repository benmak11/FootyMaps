//
//  CreateGameVC.swift
//  FootyMaps
//
//  Created by Ben Makusha on 4/24/17.
//  Copyright © 2017 Ben Makusha. All rights reserved.
//

import UIKit
import MapKit
import GooglePlacePicker

class CreateGameVC: UIViewController, CLLocationManagerDelegate {
    
    var locManager = CLLocationManager()
    var currentLocation = CLLocation()

    @IBOutlet weak var placeTextField: FancyTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func displacePlacePicker(_ sender: Any) {
        
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse){
            currentLocation = locManager.location!
        }
        
        let center = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        let northEast = CLLocationCoordinate2D(latitude: center.latitude + 0.001, longitude: center.longitude + 0.001)
        let southWest = CLLocationCoordinate2D(latitude: center.latitude - 0.001, longitude: center.longitude - 0.001)
        let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
        let config = GMSPlacePickerConfig(viewport: viewport)
        let placePicker = GMSPlacePicker(config: config)
        
        placePicker.pickPlace(callback: {(place, error) -> Void in
            if let error = error {
                print("BEN: Pick Place error: \(error.localizedDescription)")
                return
            }
            
            if let place = place {
                //self.nameLabel.text = place.name
                self.placeTextField.text = place.formattedAddress?.components(separatedBy: ", ")
                    .joined(separator: "\n")
            } else {
                //self.nameLabel.text = "No place selected"
                self.placeTextField.text = ""
            }
        })
    }
    
    @IBAction func dismissCreateGameVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
