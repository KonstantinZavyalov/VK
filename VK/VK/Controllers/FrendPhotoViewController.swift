//
//  FrendsPhotoViewController.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 08/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

class FriendsPhotoViewController: UICollectionViewController {
    
    let request = NetworkingService()
    
    public var friendProfileUserId: Int = 1
    public var friendProfileName = ""
    public var friendProfileLastname = ""
    public var friendProfilePhoto = [FriendProfilePhoto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        request.loadPhotos(friendProfileUserId) { result in
            switch result {
            case .success(let photoList):
                self.friendProfilePhoto = photoList
                self.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        let width = collectionView.bounds.width / 3.05
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width * 1.25)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        title = friendProfileName + " " + friendProfileLastname
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return friendProfilePhoto.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FrendPhotoCell.reuseId, for: indexPath) as? FrendPhotoCell else { fatalError() }
        
        cell.iconImageView.kf.setImage(with: URL(string: friendProfilePhoto[indexPath.row].photo))
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPhoto",
            let friendsBigPhotoVC = segue.destination as? PhotoFullSizeVC {
            let bigPhoto = friendProfilePhoto
            friendsBigPhotoVC.friendProfilePhoto = bigPhoto
            
        }
        
    }
}
