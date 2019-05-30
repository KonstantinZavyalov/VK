//
//  FrendCell.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 10/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class FrendCell: UITableViewCell {
    
    static let reuseId = "FrendCell"
    
    @IBOutlet var nameFrendLabel: UILabel!
    @IBOutlet var avatarFrendImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatarFrendImage.layer.cornerRadius = avatarFrendImage.bounds.height/2
    }
}
