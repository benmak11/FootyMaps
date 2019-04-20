//
//  SignInVC.swift
//  FootyMaps
//
//  Created by Ben Makusha on 4/4/17.
//  Copyright © 2017 Ben Makusha. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import SwiftKeychainWrapper

class SignInVC: UIViewController {

    // Add animation enginer object here
    
    // Add Location properties here
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Declare and announce the animation process here
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Animation showcase here
        
        // Keychain signin help
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            print("BEN: ID found in Keychain")
            // perform segue to sign in page
            performSegue(withIdentifier: "goToMapView", sender: nil)
        }
    }
    
    @IBAction func facebookBtnPressed(_ sender: AnyObject) {
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("BEN : Unable to authenticate with Facebook - \(String(describing: error))")
            } else if result?.isCancelled == true {
                print("BEN: User cancelled Facebook authentication")
            } else {
                print("BEN: Successfully authenticated with Facebook")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    // MARK: Firebase authentication with Facebook
    func firebaseAuth(_ credential: AuthCredential) {
        Auth.auth().signInAndRetrieveData(with: credential, completion: { (user, error) in
            if error != nil {
                print("BEN: Unable to authenticate with Firebase using Facebook - \(String(describing: error))")
            } else {
                print("BEN: Successfully authenticated with Firebase using Facebook")
                if let user = user {
                    var userId = user.user.uid
                    let userData = ["provider": credential.provider]
                    self.completeSignIn(id: userId, userData: userData)
                }
            }
        })
    }
    
    // MARK: Complete SignIn process
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        // MARK: Adding the provider for signin
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("BEN: Data saved to keychain - \(keychainResult)")
        performSegue(withIdentifier: "goToMapView", sender: nil)
    }
    
    // MARK: Tracking the user's location
    
}

