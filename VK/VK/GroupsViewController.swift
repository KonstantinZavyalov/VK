//
//  GroupsViewController.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 08/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

class GroupsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    let request = NetworkingService()
    private let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    private lazy var groupList: Results<Group> = try! Realm(configuration: config).objects(Group.self)
    private var notificationToken: NotificationToken?
    //private lazy var searchedGroup: Results<Group> = try! Realm(configuration: config).objects(Group.self)
    
    @IBOutlet weak var searchBar: UISearchBar! {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        view.addGestureRecognizer(tapGR)
        
        request.userGroups { result in
            switch result {
            case .success(let groupList):
                let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
                let realm = try! Realm(configuration: config)
                
                try! realm.write {
                    realm.add(groupList, update: .modified)
                }
                print(realm.configuration.fileURL!)
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        request.userGroups() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let groupList):
                let realm = try! Realm(configuration: self.config)
                try! realm.write {
                    realm.add(groupList, update: .modified)
                }
                print(realm.configuration.fileURL!)
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        notificationToken = groupList.observe { [weak self] changes in
            guard let self = self else { return }
            switch changes {
            case .initial, .update:
                self.tableView.reloadData()
            case .error(let error):
                print(error)
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        notificationToken?.invalidate()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let filteredGroups = self.groupList.filter("groupName CONTAINS[cd] %@", searchText)
        
            groupList = filteredGroups
            tableView.reloadData()
    }
    
    @objc func dissmissKeyboard() {
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return groupList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupCell.reuseId, for: indexPath) as? GroupCell else { fatalError("Cell cannot be dequeued") }
        
        cell.nameGroupLabel.text = groupList[indexPath.row].groupName
        cell.myGroupImage.kf.setImage(with: URL(string: groupList[indexPath.row].groupImage))
        
        return cell
    }
    
}
