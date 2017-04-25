//
//  MapViewVC.swift
//  FootyMaps
//
//  Created by Ben Makusha on 4/5/17.
//  Copyright © 2017 Ben Makusha. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import MapKit
import FirebaseDatabase

extension MKMapView {
    func zoomToUserLocation() {
        guard let coordinate = userLocation.location?.coordinate else { return }
        let region = MKCoordinateRegionMakeWithDistance(coordinate, 10000, 10000)
        setRegion(region, animated: true)
    }
}

class MapViewVC: UIViewController, IndicatorInfoProvider, MKMapViewDelegate, CLLocationManagerDelegate {
    
    // MARK: MapView object from Storyboard
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 200
    
    // MARK: Geofire object
    var geoFire: GeoFire!
    var geoFireRef: FIRDatabaseReference!
    
    var mapHasCenteredOnce = false;
    
    var footyGame: FootyGame?

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        mapView.userTrackingMode = MKUserTrackingMode.follow
        mapView.zoomToUserLocation()
        
        geoFireRef = FIRDatabase.database().reference()
        geoFire = GeoFire(firebaseRef: geoFireRef)                  //Initialized GeoFire
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "MAP")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        locationAuthStatus()
        mapView.reloadInputViews()
    }
    
    func locationManagerButton(){
        mapView!.setCenter(mapView!.userLocation.coordinate, animated: true)
    }
    
    func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            mapView.showsUserLocation = true
        }
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        if userLocation.location != nil {
            
            if !mapHasCenteredOnce {
                mapView.zoomToUserLocation()
                mapHasCenteredOnce = true
            }
        }
    }
    
    @IBAction func returnUserToCurrentLocation(_ sender: Any) {
        mapView.zoomToUserLocation()
    }
    
    func createSighting(forLocation location: CLLocation, withPokemon gameId: Int) {
        
        geoFire.setLocation(location, forKey: "\(gameId)")
    }
    
    func showSightingsOnMap(location: CLLocation) {
        
        let circleQuery = geoFire!.query(at: location, withRadius: 2.5)
        
        _ = circleQuery?.observe(GFEventType.keyEntered, with: {
            (key, location) in
            
            // observe whenever it finds a sighting
            if let key = key, let location = location {
                let anno = FootyGameAnnotation(coordinate: location.coordinate, gameId: Int(key)!)
                self.mapView.addAnnotation(anno)        // Finding all the pokemon within a
                                                        // location and adds them to the map
                
            }
        });
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        
        let loc = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        
        showSightingsOnMap(location: loc)
    }
    
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        
//        if let anno = view.annotation as? FootyGameAnnotation {
//            
//            var place: MKPlacemark!
//            if #available(iOS 10.0, *) {
//                place = MKPlacemark(coordinate: anno.coordinate)
//            } else {
//                place = MKPlacemark(coordinate: anno.coordinate, addressDictionary: nil)
//            }
//            let destination = MKMapItem(placemark: place)
//            destination.name = "Game Sighting"
//            let regionDistance: CLLocationDistance = 1000
//            let regionSpan = MKCoordinateRegionMakeWithDistance(anno.coordinate, regionDistance, regionDistance)
//            
//            let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey:  NSValue(mkCoordinateSpan: regionSpan.span), MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving] as [String : Any]
//            
//            MKMapItem.openMaps(with: [destination], launchOptions: options)
//        }
//    }
    

//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//
//        let annoIdentifier = "FootyGame"
//        var annotationView: MKAnnotationView?
//
//        if annotation.isKind(of: MKUserLocation.self) {
//
//            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "User")
//        } else if let deqAnno = mapView.dequeueReusableAnnotationView(withIdentifier: annoIdentifier) {
//            annotationView = deqAnno
//            annotationView?.annotation = annotation
//        } else {
//            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: annoIdentifier)
//            av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//            annotationView = av
//        }
//
//        if let annotationView = annotationView, let anno = annotation as? FootyGameAnnotation {
//
//            annotationView.canShowCallout = true
//            annotationView.image = UIImage(named: "\(anno.gameId)")
//            let btn = UIButton()
//            btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//            btn.setImage(UIImage(named: "map"), for: .normal)
//            annotationView.rightCalloutAccessoryView = btn
//        }
//
//        return annotationView
//    }
    
    func userDidTapPokemon(data: Int) {
        let loc = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        createSighting(forLocation: loc, withPokemon: data)
    }

}

