//
//  FrendsPhotoViewController.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 08/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit


class FriendsPhotoViewController: UICollectionViewController {
    
    public var friendName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = friendName
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 9
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FrendPhotoCell.reuseId, for: indexPath) as? FrendPhotoCell else { fatalError() }
        
        return cell
    }

}

