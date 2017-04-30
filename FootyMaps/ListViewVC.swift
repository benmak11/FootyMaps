//
//  ListViewVC.swift
//  FootyMaps
//
//  Created by Ben Makusha on 4/5/17.
//  Copyright © 2017 Ben Makusha. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ListViewVC: UIViewController, IndicatorInfoProvider, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var listViewTableView: UITableView!
    @IBOutlet weak var listViewSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listViewTableView.delegate = self
        listViewTableView.dataSource = self
        
        listViewSearchBar.delegate = self
        listViewSearchBar.returnKeyType = UIReturnKeyType.done
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "LIST")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return listViewTableView.dequeueReusableCell(withIdentifier: "ListViewCell") as! ListViewCell
    }
    
    
}
