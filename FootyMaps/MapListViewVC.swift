//
//  MapListViewVC.swift
//  FootyMaps
//
//  Created by Ben Makusha on 4/4/17.
//  Copyright © 2017 Ben Makusha. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper
import FBSDKShareKit

class MapListViewVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUserCredentials()
    }
    
    func setUserCredentials(){
        
        /*!
         * Credit given to Enoch Huang for providing this solution:
         * https://studyswift.blogspot.com/2016/01/facebook-sdk-and-swift-display-user.html?showComment=1479285714433#c5684049712303509664
         */
        if ((FBSDKAccessToken.current() != nil )){
            //print("BEN: FB Access Token -- \(FBSDKAccessToken.current().tokenString)")
            //print("BEN: FB Access Persmissions -- \(FBSDKAccessToken.current().permissions)")
            let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "id, name, email"])
            let connection = FBSDKGraphRequestConnection()
            
            connection.add(graphRequest, completionHandler: { (connection, result, error) -> Void in
                
                let data = result as! [String: Any]
                //USERNAME = (data["name"] as? String)!
                //print("BEN: Username is --- \(USERNAME)")
                let facebookId = data["id"] as? String
                // Potential use for Profile pic showing
                //let url = URL(string: "https://graph.facebook.com/"+facebookId!+"/picture?type=large&return_ssl_resources=1")
                //self.profileImg.image = UIImage(data: NSData(contentsOf: url! as URL)! as Data)
                //PROFILE_PICTURE = self.profileImg.image
            })
            connection.start()
            
        }
    }
    
}
