//
//  CustomNavigationController.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 12/05/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    var hasStarted = false
    var shouldFinish = false
    var viewController: UIViewController?
}

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    let transitionAnimator = Animator()
    let interactiveTransition = CustomInteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        let edgeSwipeGR = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleScreenGesture(_:)))
        //edgeSwipeGR.edges = .left
        edgeSwipeGR.edges = .right
        view.addGestureRecognizer(edgeSwipeGR)
        let edgeSwipeGRPop = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleScreenGesture(_:)))
        edgeSwipeGRPop.edges = .left
        //edgeSwipeGR.edges = .right
        view.addGestureRecognizer(edgeSwipeGRPop)
        }
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return Animator()
        case .pop:
            return PopAnimator()
        default:
            return nil
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
    
    @objc func handleScreenGesture(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            interactiveTransition.hasStarted = true
            self.popViewController(animated: true)
            
        case .changed:
            guard let width = recognizer.view?.bounds.width else {
                interactiveTransition.hasStarted = false
                interactiveTransition.cancel()
                return
            }
            let translation = recognizer.translation(in: recognizer.view)
            let relativeTranslation = translation.x / width
            let progress = max(0, min(1, relativeTranslation))
            
            interactiveTransition.shouldFinish = progress > 0.4
            interactiveTransition.update(progress)
            
        case .ended:
            interactiveTransition.hasStarted = false
            interactiveTransition.shouldFinish ? interactiveTransition.finish() : interactiveTransition.cancel()
            
        case .cancelled:
            interactiveTransition.hasStarted = false
            interactiveTransition.cancel()
        default:
            break
        }
    }
}
