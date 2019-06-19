//
//  FrendsPhotoViewController.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 08/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import RealmSwift

class FriendsPhotoViewController: UICollectionViewController {
    
    let request = NetworkingService()
    //let realm = try! Realm()
    
    public var friendProfileUserId: Int = 1
    public var friendProfileName = ""
    public var friendProfileLastname = ""
    public var friendProfilePhoto: Results<FriendProfilePhoto> = try! Realm().objects(FriendProfilePhoto.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        request.loadPhotos(friendProfileUserId) { result in
            switch result {
            case .success(let photoList):
                let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
                let realm = try! Realm(configuration: config)
                
                try! realm.write {
                    realm.add(photoList, update: .modified)
                }
                print(realm.configuration.fileURL!)
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
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return friendProfilePhoto.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FrendPhotoCell.reuseId, for: indexPath) as? FrendPhotoCell else { fatalError() }
        
        // Configure the cell
        cell.iconImageView.kf.setImage(with: URL(string: friendProfilePhoto[indexPath.row].photo))
        
        return cell
    }
    
}
