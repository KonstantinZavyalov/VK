//
//  FrendCell.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 10/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import Kingfisher

class FrendCell: UITableViewCell {
    
    static let reuseId = "FrendCell"
    
    @IBOutlet var nameFrendLabel: UILabel!
    @IBOutlet var avatarFrendImage: UIImageView!
    
    public func configure(with friend: Friend) {
        let friendname = "\(friend.firstname) \(friend.lastname)"
        nameFrendLabel.text = friendname
        
        let iconUrlString = friend.avatar
        avatarFrendImage.kf.setImage(with: URL(string: iconUrlString))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatarFrendImage.layer.cornerRadius = avatarFrendImage.bounds.height/2
    }
}
