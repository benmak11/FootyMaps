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

extension UIToolbar {
    func ToolbarPiker(mySelect : Selector) -> UIToolbar {
        let toolBar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: mySelect)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
}

class CreateGameVC: UIViewController, CLLocationManagerDelegate {
    
    var locManager = CLLocationManager()
    var currentLocation = CLLocation()

    @IBOutlet weak var placeTextField: FancyTextField!
    @IBOutlet weak var timeTextField: FancyTextField!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var gameDurationLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(CreateGameVC.dismissPicker))
        timeTextField.inputAccessoryView = toolBar

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
                self.placeTextField.text = place.formattedAddress?.components(separatedBy: ", ")
                    .joined(separator: "\n")
            } else {
                self.placeTextField.text = ""
            }
        })
    }
    
    @IBAction func textFieldEditting(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.time
        datePickerView.minuteInterval = 5
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.none
        dateFormatter.timeStyle = DateFormatter.Style.short
        timeTextField.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func changeDuration(_ sender: UISlider) {
        sender.setValue((Float)((Int)((sender.value + 15) / 30) * 30), animated: true)
        let currentValue = Int(sender.value)
        gameDurationLbl.text = "\(currentValue) m"
    }
    
    @objc func dismissPicker() {
        view.endEditing(true)
        
    }
    @IBAction func dismissCreateGameVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addingGame(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }

}
