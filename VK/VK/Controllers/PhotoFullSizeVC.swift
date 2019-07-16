//
//  PhotoFullSizeVC.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 06/05/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

private let reuseIdentifier = "Cell"

class PhotoFullSizeVC: UICollectionViewController {
    
    public var friendProfilePhoto = [FriendProfilePhoto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollViev()
        
        let swipeGR = UISwipeGestureRecognizer(target: self, action: #selector(swipePhoto))
        swipeGR.direction = [.left, .right]
        view.addGestureRecognizer(swipeGR)
        
    }
    
    @objc func swipePhoto(_ recognizer: UISwipeGestureRecognizer) {
        switch recognizer.state {
        case .began:
            print("begin")
        case .cancelled:
            print("cancel")
        case .changed:
            print("change")
        case .ended:
            print("ended")
        case .possible:
            print("possible")
        default:
            print("error")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friendProfilePhoto.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BigPhotoCell.reuseID
                , for: indexPath) as? BigPhotoCell else { fatalError() }
        
        cell.bigFriendPhoto.kf.setImage(with: URL(string: friendProfilePhoto[indexPath.row].photo))
        
        return cell
    }
    
    func setupScrollViev() {
        
        let size = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: size.width, height: size.height)
        layout.sectionHeadersPinToVisibleBounds = true
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.backgroundColor = .black
        
        collectionView.isPagingEnabled = true
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        cell.contentView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        let propertyAnimator = UIViewPropertyAnimator(duration: 0.6, curve: .easeOut) {
            cell.contentView.transform = .identity
        }
        
        propertyAnimator.startAnimation()
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.1, delay: 0, options: [.curveLinear, .curveEaseOut], animations: {
            cell!.contentView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: nil)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        
        UIView.animate(withDuration: 0.1, delay: 0, options: [.curveLinear, .curveEaseIn], animations: {
            cell!.contentView.transform = .identity
        }, completion: nil)
        
    }
    
}
