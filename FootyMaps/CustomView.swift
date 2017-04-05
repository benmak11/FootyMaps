//
//  CustomView.swift
//  FootyMaps
//
//  Created by Ben Makusha on 4/4/17.
//  Copyright © 2017 Ben Makusha. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
    
}
