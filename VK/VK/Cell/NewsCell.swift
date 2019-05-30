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
    
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var nameGroupLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    //@IBOutlet var addDescriptionImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func TapAnimationButton(_ sender: Any) {
        
//        let animation = CABasicAnimation(keyPath: "transform.scale")
//        animation.toValue = NSNumber(value: 2)
//        animation.duration = 1
//        animation.repeatCount = 0
//        animation.autoreverses = false
//
//        addDescriptionImageView.layer.add(animation, forKey: "animation")
        
//        let pulse =  CASpringAnimation(keyPath: "transform.scale")
//        pulse.duration =  0.2
//        pulse.fromValue = 0.95
//        pulse.toValue = 1.0
//        pulse.autoreverses = false
//        pulse.repeatCount = 0
//        pulse.initialVelocity = 0.1
//        pulse.damping = 1.0
//
//        addDescriptionImageView.layer.add(pulse, forKey: "pulse")
        }

}
