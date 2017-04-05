//
//  CustomCircleImageView.swift
//  FootyMaps
//
//  Created by Ben Makusha on 4/4/17.
//  Copyright © 2017 Ben Makusha. All rights reserved.
//

import UIKit

class CustomCircleImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
    }
    
}
