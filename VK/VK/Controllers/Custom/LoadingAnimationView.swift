//
//  LoadingAnimationView.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 03/05/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class LoadingAnimationView: UIView {
    let dotView0 = UIView()
    let dotView1 = UIView()
    let dotView2 = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    private func setupView() {
        addSubview(dotView0)
        addSubview(dotView1)
        addSubview(dotView2)
        
        dotView0.backgroundColor = .lightGray
        dotView0.clipsToBounds = true
        dotView1.backgroundColor = .lightGray
        dotView1.clipsToBounds = true
        dotView2.backgroundColor = .lightGray
        dotView2.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = CGSize(width: bounds.height, height: bounds.height)
        let offset = bounds.width / 3
        
        let origin0 = CGPoint(x: 0, y: 0)
        dotView0.frame = CGRect(origin: origin0, size: size)
        dotView0.layer.cornerRadius = bounds.height/2
        let origin1 = CGPoint(x: offset, y: 0)
        dotView1.frame = CGRect(origin: origin1, size: size)
        dotView1.layer.cornerRadius = bounds.height/2
        let origin2 = CGPoint(x: 2*offset, y: 0)
        dotView2.frame = CGRect(origin: origin2, size: size)
        dotView2.layer.cornerRadius = bounds.height/2
    }
    
    public func startAnimating() {
        UIView.animate(withDuration: 0.6, delay: 0, options: [.autoreverse, .curveEaseInOut, .repeat], animations: {
            self.dotView0.alpha = 0
        }, completion: nil)
        UIView.animate(withDuration: 0.6, delay: 0.1, options: [.autoreverse, .curveEaseInOut, .repeat], animations: {
            self.dotView1.alpha = 0
        }, completion: nil)
        UIView.animate(withDuration: 0.6, delay: 0.2, options: [.autoreverse, .curveEaseInOut, .repeat], animations: {
            self.dotView2.alpha = 0
        }, completion: nil)
    }
    
    public func stopAnimating() {
        dotView0.layer.removeAllAnimations()
        dotView1.layer.removeAllAnimations()
        dotView2.layer.removeAllAnimations()

        isHidden = true
    }
}
