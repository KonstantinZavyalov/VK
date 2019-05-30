//
//  MusicCell.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 17/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class MusicCell: UITableViewCell {
    
    static let reuseId = "MusicCell"
    
    @IBOutlet var nameMusicLabel: UILabel!
    @IBOutlet var coverImageView: UIImageView!
    @IBOutlet var durationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
