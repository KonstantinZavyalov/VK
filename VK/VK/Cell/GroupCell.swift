//
//  GroupCell.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 10/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import Kingfisher

class GroupCell: UITableViewCell {
    
    static let reuseId = "GroupCell"
    
    @IBOutlet var nameGroupLabel: UILabel!
    @IBOutlet var myGroupImage: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myGroupImage.layer.cornerRadius = myGroupImage.bounds.height/2
    }

}
