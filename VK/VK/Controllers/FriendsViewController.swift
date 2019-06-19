//
//  FrendsViewController.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 08/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

class FriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let vkRequest = NetworkingService()
    //let realm = try! Realm()
    private var friendsList: Results<FriendProfile> = try! Realm().objects(FriendProfile.self)
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vkRequest.loadFriends { result in
            switch result {
            case .success(let friendList):
                let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
                let realm = try! Realm(configuration: config)
                
                try! realm.write {
                    realm.add(friendList, update: .modified)
                }
                print(realm.configuration.fileURL!)
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return friendsList.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FrendCell.reuseId, for: indexPath) as? FrendCell else { fatalError("Cell cannot be dequeued") }
        
        cell.nameFrendLabel.text = friendsList[indexPath.row].name + " " + friendsList[indexPath.row].lastname
        cell.avatarFrendImage.kf.setImage(with: URL(string: friendsList[indexPath.row].avatarImage))
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FriendsProfileController",
            let friendsProfileVC = segue.destination as? FriendsPhotoViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            
            let friendProfileUserId = friendsList[indexPath.row].userid
            let friendProfileName = friendsList[indexPath.row].name
            let friendProfileLastname = friendsList[indexPath.row].lastname
            
            friendsProfileVC.friendProfileUserId = friendProfileUserId
            friendsProfileVC.friendProfileName = friendProfileName
            friendsProfileVC.friendProfileLastname = friendProfileLastname
        }

    }
}
