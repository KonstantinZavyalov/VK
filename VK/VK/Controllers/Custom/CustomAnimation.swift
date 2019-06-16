//
//  CustomAnimation.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 12/05/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

public let π = CGFloat.pi

class Animator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    private let animationDuration: TimeInterval = 0.6
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        transitionContext.containerView.addSubview(destination.view)
        destination.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
        destination.view.frame = transitionContext.containerView.frame
        destination.view.transform = CGAffineTransform(rotationAngle: -π/2)
        
        UIView.animate(withDuration: animationDuration, animations: {
            destination.view.transform = .identity
        }, completion: { finished in
            transitionContext.completeTransition(finished)
        })
    }
}

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    private let animationDuration: TimeInterval = 0.6
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let source = transitionContext.viewController(forKey: .to) else { return }
        transitionContext.containerView.addSubview(source.view)
        source.view.layer.anchorPoint = CGPoint(x: 0, y: 0)
        source.view.frame = transitionContext.containerView.frame
        source.view.transform = CGAffineTransform(rotationAngle: π/2)
        
        UIView.animate(withDuration: animationDuration, animations: {
            source.view.transform = .identity
        }, completion: { finished in
            transitionContext.completeTransition(finished)
        })
    }
}
