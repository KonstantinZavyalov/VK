//
//  NewsCell.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 26/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    static let reuseId = "NewsCell"
    
    @IBOutlet weak var textNewsLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var imageNewsView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
