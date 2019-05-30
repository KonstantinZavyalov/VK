//
//  File.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 16/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    
    override func awakeFromNib() {
        layer.cornerRadius = bounds.height/2
        layer.shadowColor = UIColor.green.cgColor
        layer.shadowRadius = 7
        layer.shadowOpacity = 0.75
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.height/2
    }
}
