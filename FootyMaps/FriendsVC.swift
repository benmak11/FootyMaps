//
//  FriendsVC.swift
//  FootyMaps
//
//  Created by Ben Makusha on 4/20/17.
//  Copyright © 2017 Ben Makusha. All rights reserved.
//

import UIKit

class FriendsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    @IBOutlet weak var footballersTableView: UITableView!
    @IBOutlet weak var footballersSearchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        footballersTableView.delegate = self
        footballersTableView.dataSource = self
        
        footballersSearchBar.delegate = self
        footballersSearchBar.returnKeyType = UIReturnKeyType.done

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}
