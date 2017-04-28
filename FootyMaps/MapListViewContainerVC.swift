//
//  MapListViewContainerVC.swift
//  FootyMaps
//
//  Created by Ben Makusha on 4/4/17.
//  Copyright © 2017 Ben Makusha. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper
import FBSDKShareKit
import XLPagerTabStrip

/*
** Used the https://github.com/xmartlabs/XLPagerTabStrip provided by https://xmartlabs.com/
** to make the page tab strip
*/

class MapListViewContainerVC: ButtonBarPagerTabStripViewController {
    
    var profileDetailVC: ProfileDetailVC!
    
    let purpleInspireColor = UIColor(red: 0.13, green: 0.03, blue: 0.25, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // change selected bar color
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = purpleInspireColor
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .black
            newCell?.label.textColor = self?.purpleInspireColor
        }
        
        self.setUserCredentials()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let child_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "child1")
        let child_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "child2")
        
        return [child_1, child_2]
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
                //print("BEN: Username is --- \(USERNAME)")
                //let facebookId = data["id"] as? String
                //let url = URL(string: "https://graph.facebook.com/"+facebookId!+"/picture?type=large&return_ssl_resources=1")
                //self.profileDetailVC.profileImg.image = UIImage(data: NSData(contentsOf: url! as URL)! as Data)
                //PROFILE_PICTURE = self.profileDetailVC.profileImg.image
            })
            connection.start()
            
        }
    }
    
}
