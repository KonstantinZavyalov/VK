//
//  CustomAnimator.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 12/05/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class Animator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate  {
    
    private let animationDuration: TimeInterval = 1
    let transitionManager = Animator()
    var presenting = true
    
    func prepareForSegue (segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let toViewController = segue.destination as UIViewController
        
        toViewController.transitioningDelegate = self.transitionManager
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
        let container = transitionContext.containerView
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        let offScreenRight = CGAffineTransform(translationX: container.frame.width, y: 0)
        let offScreenLeft = CGAffineTransform(translationX: -container.frame.width, y: 0)
        
        let π = CGFloat.pi
        
        let offScreenRotateIn = CGAffineTransform(rotationAngle: -π/2)
        let offScreenRotateOut = CGAffineTransform(rotationAngle: π/2)
        
        toView.transform = self.presenting ? offScreenRotateIn : offScreenRotateOut
        
        toView.layer.anchorPoint = CGPoint(x:0, y:0)
        fromView.layer.anchorPoint = CGPoint(x:0, y:0)
        
        toView.layer.position = CGPoint(x:0, y:0)
        fromView.layer.position = CGPoint(x:0, y:0)
        
        if self.presenting {
            toView.transform = offScreenRight
        } else {
            toView.transform = offScreenLeft
        }
        
        container.addSubview(toView)
        container.addSubview(fromView)
        
        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.49, initialSpringVelocity: 0.81, options: [], animations: { () -> Void in
            
            if self.presenting {
                fromView.transform = offScreenLeft
            } else {
                fromView.transform = offScreenRight
            }
            
            toView.transform = CGAffineTransform.identity
            
            }) { (finished) -> Void in
            
                transitionContext.completeTransition(true)
        }
    }
    
    func transitionDuration (using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
}

//class Animator: NSObject, UIViewControllerAnimatedTransitioning {
//    private let animationDuration: TimeInterval = 1
//
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return animationDuration
//    }
//
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        guard let source = transitionContext.viewController(forKey: .from),
//            let destination = transitionContext.viewController(forKey: .to) else { return }
//
//        transitionContext.containerView.addSubview(destination.view)
//        source.view.frame = transitionContext.containerView.frame
//        destination.view.frame = transitionContext.containerView.frame
//        destination.view.transform = CGAffineTransform(translationX: source.view.bounds.width,
//                                                       y: source.view.bounds.height)
//
//        UIView.animate(withDuration: animationDuration, animations: {
//            destination.view.transform = .identity
//        }, completion: { finished in
//            transitionContext.completeTransition(finished)
//        })
//    }
//}
//
//class PushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
//
//    private let animationDuration: TimeInterval = 1
//
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//
//        let container = transitionContext.containerView
//        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
//        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
//
//        let offScreenRight = CGAffineTransform(translationX: container.frame.width, y: 0)
//        let offScreenLeft = CGAffineTransform(translationX: -container.frame.width, y: 0)
//
//        let π = CGFloat.pi
//
//        let offScreenRotateIn = CGAffineTransform(rotationAngle: -π/2)
//        let offScreenRotateOut = CGAffineTransform(rotationAngle: π/2)
//
//        toView.transform = self.presenting ? offScreenRotateIn : offScreenRotateOut
//
//        toView.layer.anchorPoint = CGPoint(x:0, y:0)
//        fromView.layer.anchorPoint = CGPoint(x:0, y:0)
//
//        toView.layer.position = CGPoint(x:0, y:0)
//        fromView.layer.position = CGPoint(x:0, y:0)
//
//        if self.presenting {
//            toView.transform = offScreenRight
//        } else {
//            toView.transform = offScreenLeft
//        }
//
//        container.addSubview(toView)
//        container.addSubview(fromView)
//
//        let duration = self.transitionDuration(using: transitionContext)
//
//        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.49, initialSpringVelocity: 0.81, options: [], animations: { () -> Void in
//
//            if self.presenting {
//                fromView.transform = offScreenLeft
//            } else {
//                fromView.transform = offScreenRight
//            }
//
//            toView.transform = CGAffineTransform.identity
//
//        }) { (finished) -> Void in
//
//            transitionContext.completeTransition(true)
//        }
//    }
//
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return animationDuration
//    }
//
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        guard let source = transitionContext.viewController(forKey: .from),
//            let destination = transitionContext.viewController(forKey: .to) else { return }
//
//        transitionContext.containerView.addSubview(destination.view)
//        source.view.frame = transitionContext.containerView.frame
//        destination.view.frame = transitionContext.containerView.frame
//        destination.view.transform = CGAffineTransform(translationX: source.view.bounds.width,
//                                                       y: 0)
//
//        UIView.animateKeyframes(withDuration: animationDuration, delay: 0, options: .calculationModePaced, animations: {
//            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.75, animations: {
//                let translation = CGAffineTransform(translationX: -200, y: 0)
//                let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
//                source.view.transform = translation.concatenating(scale)
//            })
//            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.4, animations: {
//                let translation = CGAffineTransform(translationX: source.view.bounds.width/2,
//                                                    y: 0)
//                let scale = CGAffineTransform(scaleX: 1.2, y: 1.2)
//                destination.view.transform = translation.concatenating(scale)
//            })
//            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4, animations: {
//                destination.view.transform = .identity
//            })
//        }) { finished in
//            if finished && !transitionContext.transitionWasCancelled {
//                source.view.transform = .identity
//            }
//            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
//        }
//    }
//}
//
//class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
//
//    private let animationDuration: TimeInterval = 1
//
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return animationDuration
//    }
//
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//
//        let container = transitionContext.containerView
//        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
//        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
//
//        let offScreenRight = CGAffineTransform(translationX: container.frame.width, y: 0)
//        let offScreenLeft = CGAffineTransform(translationX: -container.frame.width, y: 0)
//
//        let π = CGFloat.pi
//
//        let offScreenRotateIn = CGAffineTransform(rotationAngle: -π/2)
//        let offScreenRotateOut = CGAffineTransform(rotationAngle: π/2)
//
//        toView.transform = self.presenting ? offScreenRotateIn : offScreenRotateOut
//
//        toView.layer.anchorPoint = CGPoint(x:0, y:0)
//        fromView.layer.anchorPoint = CGPoint(x:0, y:0)
//
//        toView.layer.position = CGPoint(x:0, y:0)
//        fromView.layer.position = CGPoint(x:0, y:0)
//
//        if self.presenting {
//            toView.transform = offScreenRight
//        } else {
//            toView.transform = offScreenLeft
//        }
//
//        container.addSubview(toView)
//        container.addSubview(fromView)
//
//        let duration = self.transitionDuration(using: transitionContext)
//
//        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.49, initialSpringVelocity: 0.81, options: [], animations: { () -> Void in
//
//            if self.presenting {
//                fromView.transform = offScreenLeft
//            } else {
//                fromView.transform = offScreenRight
//            }
//
//            toView.transform = CGAffineTransform.identity
//
//        }) { (finished) -> Void in
//
//            transitionContext.completeTransition(true)
//        }
//    }
//
//
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        guard let source = transitionContext.viewController(forKey: .from),
//            let destination = transitionContext.viewController(forKey: .to) else { return }
//
//        transitionContext.containerView.addSubview(destination.view)
//        transitionContext.containerView.sendSubviewToBack(destination.view)
//
//        source.view.frame = transitionContext.containerView.frame
//        destination.view.frame = transitionContext.containerView.frame
//        let translation = CGAffineTransform(translationX: -200, y: 0)
//        let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
//        destination.view.transform = translation.concatenating(scale)
//
//        UIView.animateKeyframes(withDuration: animationDuration, delay: 0, options: .calculationModePaced, animations: {
//            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.75, animations: {
//                destination.view.transform = .identity
//            })
//
//            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4, animations: {
//                let translation = CGAffineTransform(translationX: source.view.bounds.width/2,
//                                                    y: 0)
//                let scale = CGAffineTransform(scaleX: 1.2, y: 1.2)
//                source.view.transform = translation.concatenating(scale)
//            })
//
//            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.4, animations: {
//                source.view.transform = CGAffineTransform(translationX: source.view.bounds.width,
//                                                          y: 0)
//            })
//        }) { finished in
//            if finished && !transitionContext.transitionWasCancelled {
//                source.removeFromParent()
//            } else if transitionContext.transitionWasCancelled {
//                destination.view.transform = .identity
//            }
//            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
//        }
//    }
//}
