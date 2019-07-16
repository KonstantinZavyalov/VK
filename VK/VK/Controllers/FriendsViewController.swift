//
//  FrendsViewController.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 08/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

class FriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    let vkRequest = NetworkingService()
    private var friendsList = [Friend]()
    var sectionTitle = [String]()
    var sectionDictionary = [String: [Friend]]()
    var searchingSectionTitle = [String]()
    var searchingSectionDictionary = [String: [Friend]]()
    var searchingFriendList = [Friend]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vkRequest.loadFriends { result in
            switch result {
            case .success(let friendList):
                self.friendsList = friendList
                self.sectionArrayPrepare()
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        if !isFiltering() {
        }
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск друзей"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        var sections = sectionTitle
        
        if isFiltering() {
            sections = searchingSectionTitle
        }
        
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var dictionary = sectionDictionary
        var sections = sectionTitle
        
        if isFiltering() {
            dictionary = searchingSectionDictionary
            sections = searchingSectionTitle
        }
        
        let lastnameKey = sections[section]
        if let lastnameValues = dictionary[lastnameKey] {
            return lastnameValues.count
        }
        
        return 0
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FrendCell.reuseId, for: indexPath) as? FrendCell else { fatalError("Cell cannot be dequeued") }
        
        var sections = sectionTitle
        var dictionary = sectionDictionary
        
        if isFiltering() {
            dictionary = searchingSectionDictionary
            sections = searchingSectionTitle
        }
        
        let lastnameKey = sections[indexPath.section]
        if let lastnameValues = dictionary[lastnameKey] {
            cell.nameFrendLabel.text = lastnameValues[indexPath.row].firstname + " " + lastnameValues[indexPath.row].lastname
            cell.avatarFrendImage.kf.setImage(with: URL(string: lastnameValues[indexPath.row].avatar))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sections = sectionTitle
        
        if isFiltering() {
            sections = searchingSectionTitle
        }
        
        return sections[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var sections = sectionTitle
        
        if isFiltering() {
            sections = searchingSectionTitle
        }
        return sections
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FriendsProfileController",
            let friendsProfileVC = segue.destination as? FriendsPhotoViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            
            var dictionary = sectionDictionary
            var sections = sectionTitle
            
            if isFiltering() {
                dictionary = searchingSectionDictionary
                sections = searchingSectionTitle
            }
            let lastnameKey = sections[indexPath.section]
            
            if let lastnameValues = dictionary[lastnameKey] {
                let friendProfileUserId = lastnameValues[indexPath.row].id
                let friendProfileName = lastnameValues[indexPath.row].firstname
                let friendProfileLastname = lastnameValues[indexPath.row].lastname
                friendsProfileVC.friendProfileUserId = friendProfileUserId
                friendsProfileVC.friendProfileName = friendProfileName
                friendsProfileVC.friendProfileLastname = friendProfileLastname
                
            }
        }
        
    }
    
    // MARK: - Extantion function
    
    func sectionArrayPrepare() {
        
        for lastname in friendsList {
            let lastnameKey = String(lastname.lastname.prefix(1))
            if var lastnameValues = sectionDictionary[lastnameKey] {
                lastnameValues.append(Friend(id: lastname.id, firstname: lastname.firstname, lastname: lastname.lastname, avatar: lastname.avatar))
                sectionDictionary[lastnameKey] = lastnameValues
            } else {
                sectionDictionary[lastnameKey] = [Friend(id: lastname.id, firstname: lastname.firstname, lastname: lastname.lastname, avatar: lastname.avatar)]
            }
        }
        
        sectionTitle = [String](sectionDictionary.keys)
        sectionTitle = sectionTitle.sorted(by: { $0 < $1 })
        
    }
    
    // MARK: SearcBar functions
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    
    
    func filterContentForSearchText(_ searchText: String) {
        searchingFriendList = friendsList.filter({( name : Friend) -> Bool in
            return name.firstname.lowercased().contains(searchText.lowercased()) || name.lastname.lowercased().contains(searchText.lowercased())
        })
        
        searchingSectionDictionary.removeAll()
        searchingSectionTitle.removeAll()
        
        for lastname in searchingFriendList {
            let lastnameKey = String(lastname.lastname.prefix(1))
            if var lastnameValues = searchingSectionDictionary[lastnameKey] {
                lastnameValues.append(Friend(id: lastname.id, firstname: lastname.firstname, lastname: lastname.lastname, avatar: lastname.avatar))
                searchingSectionDictionary[lastnameKey] = lastnameValues
            } else {
                searchingSectionDictionary[lastnameKey] = [Friend(id: lastname.id, firstname: lastname.firstname, lastname: lastname.lastname, avatar: lastname.avatar)]
            }
        }
        
        searchingSectionTitle = [String](searchingSectionDictionary.keys)
        searchingSectionTitle = searchingSectionTitle.sorted(by: { $0 < $1 })
        
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
}

extension FriendsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
