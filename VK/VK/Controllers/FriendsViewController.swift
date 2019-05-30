//
//  FrendsViewController.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 08/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    
    var friendsDictionary = [String : [String]]()
    var friendsSectionTitles = [String]()
    var filterFriends = [Firend]()
    public var friends: [Firend] = [
        Firend(name: "Bazilio", avatarImageView: UIImage(named: "Kot_Bazilio")),
        Firend(name: "Maks", avatarImageView: UIImage(named: "Maks")),
        Firend(name: "Roberto", avatarImageView: UIImage(named: "Minion")),
        Firend(name: "PO", avatarImageView: UIImage(named: "PO"))
    ]
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    @IBOutlet weak var searchBar: UISearchBar!
    
    fileprivate func sortFriends() {
        
        friendsDictionary = [:]
        friendsSectionTitles = []
        
        for friend in filterFriends {
            let friendKey = String(friend.name.prefix(1))
            if var friendValues = friendsDictionary[friendKey] {
                friendValues.append(friend.name)
                friendsDictionary[friendKey] = friendValues
            } else {
                friendsDictionary[friendKey] = [friend.name]
            }
        }
        
        friendsSectionTitles = [String](friendsDictionary.keys)
        friendsSectionTitles = friendsSectionTitles.sorted { $0 < $1 }
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
        
        filterFriends = friends.sorted { $0.name < $1.name }
        sortFriends()
    }
    
    private func setUpSearchBar() {
        searchBar.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return friendsSectionTitles.count
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //Sorted by letters
        let frendKey = friendsSectionTitles[section]
        if let frendValues = friendsDictionary[frendKey] {
            
            return frendValues.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FrendCell.reuseId, for: indexPath) as? FrendCell else { fatalError("Cell cannot be dequeued") }
        
        let frendKey = friendsSectionTitles[indexPath.section]
        if friendsDictionary[frendKey] != nil {
            cell.nameFrendLabel.text = filterFriends[indexPath.section].name
            cell.avatarFrendImage.image = filterFriends[indexPath.section].avatarImageView
        }
        return cell
    }
    
    func tableView(_  tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
        return friendsSectionTitles[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
    
        return friendsSectionTitles
    }
    
    //MARK: Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filterFriends = friends.sorted { $0.name < $1.name }
            sortFriends()
            tableView.reloadData()
            return
        }
        
        filterFriends = friends.filter( {Friend -> Bool in
            return Friend.name.lowercased().contains(searchText.lowercased())
        })
        filterFriends.sort { $0.name < $1.name }
        sortFriends()
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Show Photo",
            let frendPhotoVC = segue.destination as? FriendsPhotoViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            let frendName = friends[indexPath.row].name
            frendPhotoVC.friendName = frendName
        }
    }

}
