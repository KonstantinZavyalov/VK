//
//  LikeControl.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 17/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class LikeControl: UIControl {
    
    public var isLiked: Bool = false
    let heartImageView = UIImageView()
    //var likeCountLabel = UILabel()
    //var count: Int = 0
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    func setupView() {
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        self.addGestureRecognizer(tapGR)
        
        addSubview(heartImageView)
        //addSubview(likeCountLabel)
        heartImageView.image = UIImage(named: "heart_empty")
        //likeCountLabel.text = "\(count)"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        heartImageView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
//        likeCountLabel.frame = CGRect(x: bounds.width/1.5, y: 0, width: bounds.width/2, height: bounds.height)
    }

    //MARK: - Privates
    @objc func likeTapped() {
        isLiked.toggle()
        heartImageView.image = isLiked ? UIImage(named: "heart_filled") : UIImage(named: "heart_empty")
    
        UIView.animate(withDuration: 0, delay: 0.2, animations: {
            self.heartImageView.alpha = 0.5
        })
        UIView.animate(withDuration: 0.2, delay: 0.2, animations: {
            self.heartImageView.alpha = 1
        })

//        if isLiked == true {
//            count += 1
//            likeCountLabel.text = "\(count)"
//        }; if isLiked == false {
//            count -= 1
//            likeCountLabel.text = "\(count)"
//        }
    }
    
}
