//
//  CustomSegue.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 12/05/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class CustomSegue: UIStoryboardSegue {
    
    let animationDuration: TimeInterval = 0.6
    
    override func perform() {
        
        let toViewController = self.destination
        let fromViewController = self.source
        let containerView = fromViewController.view.superview
        let originalCenter = fromViewController.view.center

        toViewController.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
        toViewController.view.center = originalCenter

        containerView?.addSubview(toViewController.view)

        UIView.animate(withDuration: animationDuration, delay: 0,
                       options: .curveEaseInOut, animations: {
            toViewController.view.transform = CGAffineTransform.identity
        }, completion: { _ in
            toViewController.view.removeFromSuperview() 
            fromViewController.present(toViewController, animated: false)
        })
        
    }
    
}
