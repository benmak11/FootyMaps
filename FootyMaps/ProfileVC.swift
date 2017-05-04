//
//  ProfileVC.swift
//  FootyMaps
//
//  Created by Ben Makusha on 4/20/17.
//  Copyright © 2017 Ben Makusha. All rights reserved.
//

import UIKit
import Firebase
import FBSDKShareKit
import SwiftKeychainWrapper

class ProfileVC: UIViewController {

    @IBOutlet weak var realNameFB: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var favFootballerLbl: UILabel!
    @IBOutlet weak var numOfColleagues: UILabel!
    @IBOutlet weak var FBProfilePicture: UIImageView!
    @IBOutlet weak var faceBookNameLbl: UILabel!
    
    var profile = [Profile]()
    
    private var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUserCredentials()
        
        configureProfileVC()
    }
    
    func configureProfileVC(){
        
        DataService.ds.REF_USER_CURRENT.observe(.value, with: { (snapshot) in
            let values = snapshot.value as? [String: Any]
            
            if let userAge = values!["age"] as? String {
                self.ageLbl.text = userAge
            }
            
            if let userName = values!["username"] as? String {
                self.realNameFB.text = userName
            }
            
            if let userFavPlayer = values!["favoriteFootballer"] as? String {
                self.favFootballerLbl.text = userFavPlayer
            }
        })
        
        // MARK: Need to set the colleagues the user has here
    }

    @IBAction func signOutButtonPushed(_ sender: Any) {
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("BEN: removed id from keychain \(keychainResult)")
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
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
                USERNAME = (data["name"] as? String)!
                self.faceBookNameLbl.text = USERNAME
                //print("BEN: Username is --- \(USERNAME)")
                let facebookId = data["id"] as? String
                let url = URL(string: "https://graph.facebook.com/"+facebookId!+"/picture?type=large&return_ssl_resources=1")
                self.FBProfilePicture.image = UIImage(data: NSData(contentsOf: url! as URL)! as Data)
                PROFILE_PICTURE = self.FBProfilePicture.image
            })
            connection.start()
        }
    }

}
