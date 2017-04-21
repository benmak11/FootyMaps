//
//  ListViewCell.swift
//  FootyMaps
//
//  Created by Ben Makusha on 4/20/17.
//  Copyright © 2017 Ben Makusha. All rights reserved.
//

import UIKit

class ListViewCell: UITableViewCell {

    @IBOutlet weak var listViewProfileImage: CustomCircleImageView!
    @IBOutlet weak var listViewProfileLbl: UILabel!
    @IBOutlet weak var gameStatusLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(){
        
    }

}
