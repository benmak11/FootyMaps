//
//  ProfileDetailVC.swift
//  FootyMaps
//
//  Created by Ben Makusha on 4/26/17.
//  Copyright © 2017 Ben Makusha. All rights reserved.
//

import UIKit
import Firebase

class ProfileDetailVC: UIViewController {

    @IBOutlet weak var profileImg: CustomCircleImageView!
    @IBOutlet weak var usernameTextField: FancyTextField!
    @IBOutlet weak var ageTextField: FancyTextField!
    @IBOutlet weak var favoriteFootballerTextField: FancyTextField!
    @IBOutlet weak var email: FancyTextField!
    
    var profile: Profile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateUI()
    }
    
    func setup(){
        //setup the user's image from facebook here
    }
    
    func updateUI(){
        
        DataService.ds.REF_USER_CURRENT.observe(.value, with: { (snapshot) in
            let values = snapshot.value as? [String: Any]
            
            if let userAge = values!["age"] as? String {
                self.ageTextField.text = userAge
            }
            
            if let userName = values!["username"] as? String {
                self.usernameTextField.text = userName
            }
            
            if let userEmail = values!["email"] as? String {
                self.email.text = userEmail
            }
            
            if let userFavPlayer = values!["favoriteFootballer"] as? String {
                self.favoriteFootballerTextField.text = userFavPlayer
            }
        })
    }
    
    func postUserDetailsToFirebase(){
        let userDetails: Dictionary<String, Any> = [
            "age": ageTextField.text!,
            "username": usernameTextField.text!,
            "favoriteFootballer": favoriteFootballerTextField.text!,
            "email": email.text!,
            "postedDate": FIRServerValue.timestamp()
        ]
        print("BEN: postID is \(DataService.ds.REF_USER_CURRENT)")
        let firebaseSetUserCreds = DataService.ds.REF_USER_CURRENT
        firebaseSetUserCreds.setValue(userDetails)
        
        usernameTextField.text = ""
        ageTextField.text = ""
        favoriteFootballerTextField.text = ""
        email.text = ""
    }
    
    @IBAction func dismissEditProfile(_ sender: Any) {
        if usernameTextField != nil {
            usernameTextField.text = ""
        }
        
        if ageTextField != nil {
            ageTextField.text = ""
        }
        
        if favoriteFootballerTextField != nil {
            favoriteFootballerTextField.text = ""
        }
        
        if email != nil {
            email.text = ""
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitCredentials(_ sender: Any){
        guard let username = usernameTextField.text, username != "" else {
            let alertController = UIAlertController(title: "No Username added", message: "You must enter a cool username 🙂", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        guard let age = ageTextField.text, age != "" else {
            //print("BEN: You must post the subject you're struggling with")
            let alertController = UIAlertController(title: "Need your age", message: "Please enter your age 🙂", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        self.postUserDetailsToFirebase()
        dismiss(animated: true, completion: nil)
    }
}
