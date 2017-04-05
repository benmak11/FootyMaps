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

class MapViewVC: UIViewController, IndicatorInfoProvider, MKMapViewDelegate, CLLocationManagerDelegate {
    
    // MARK: Geofire object
    var geoFire: GeoFire!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "MAP")
    }

}
