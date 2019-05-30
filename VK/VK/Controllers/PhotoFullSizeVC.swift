//
//  PhotoFullSizeVC.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 06/05/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class PhotoFullSizeVC: UIViewController {
    
    var images = [
        UIImage(named: "PO")!,
        UIImage(named: "Minion")!,
        UIImage(named: "Maks")!,
        UIImage(named: "Kot_Bazilio")!
    ]
    var currentIndex: Int = 0
    
    @IBOutlet weak var swipeImages: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftSwipe =  UISwipeGestureRecognizer(target: self, action: #selector(swipeImage(_:)))
        let rightSwipe =  UISwipeGestureRecognizer(target: self, action: #selector(swipeImage(_:)))
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeImage(_:)))
        
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        downSwipe.direction = .down
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(downSwipe)
    }
    
    @objc func swipeImage (_ sender:UISwipeGestureRecognizer) {
        
        if (sender.direction == .left) {
            print("Swipe Left")
            
            let animation = CABasicAnimation(keyPath: "transform.scale")
            animation.toValue = NSNumber(value: 0.9)
            animation.duration = 0.2
            animation.repeatCount = 0
            animation.autoreverses = true
            
            swipeImages.layer.add(animation, forKey: nil)
            
            let transition = CATransition()
            transition.duration = 0.4
            transition.type = CATransitionType.reveal
            transition.subtype = CATransitionSubtype.fromRight
            swipeImages.layer.add(transition, forKey: kCATransition)
            
            guard currentIndex < images.count - 1 else { return }
            
            currentIndex += 1
            swipeImages.image = images [currentIndex]
        }
        
        if (sender.direction == .right) {
            print("Swipe Right")
            
            let animation = CABasicAnimation(keyPath: "transform.scale")
            animation.toValue = NSNumber(value: 0.9)
            animation.duration = 0.2
            animation.repeatCount = 0
            animation.autoreverses = true
            
            swipeImages.layer.add(animation, forKey: nil)

            let transition = CATransition()
            transition.duration = 0.4
            transition.type = CATransitionType.reveal
            transition.subtype = CATransitionSubtype.fromLeft
            swipeImages.layer.add(transition, forKey: kCATransition)
            
            guard currentIndex >= 1 else { return }
            
            currentIndex -= 1
            swipeImages.image = images [currentIndex]
        }
        
        if (sender.direction == .down) {
            print("Swipe Down")
            
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
}
