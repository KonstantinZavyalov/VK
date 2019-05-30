//
//  LikeCountLabel.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 21/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class LikeCountLabel: UILabel {
    
        var likeCount = UILabel()
        var count: Int = 0

        override func setupView() {
            
            let tapGR = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
            self.addGestureRecognizer(tapGR)
            
            addSubview(likeCount)
        }
    
        override func layoutSubviews() {
            super.layoutSubviews()
            
            likeCount.frame = bounds
        }
    
        if isLiked == true {
        count += 1
        likeCount.text = "\(count)"
        } else {
        count += -1
        likeCount.text = "\(count)"
        }
    
}
