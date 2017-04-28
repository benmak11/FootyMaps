//
//  ProfileVC.swift
//  FootyMaps
//
//  Created by Ben Makusha on 4/20/17.
//  Copyright © 2017 Ben Makusha. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class ProfileVC: UIViewController {

    @IBOutlet weak var realNameFB: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var favFootballerLbl: UILabel!
    @IBOutlet weak var numOfColleagues: UILabel!
    
    var profile = [Profile]()
    
    private var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureProfileVC()
    }
    
    func configureProfileVC(){
        //print("BEN: --- \(USERNAME))")
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
        
        // Need to set the colleagues the user has
    }

    @IBAction func signOutButtonPushed(_ sender: Any) {
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("BEN: removed id from keychain \(keychainResult)")
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
}
