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

class GroupsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let request = NetworkingService()
    let realm = try! Realm()
    private var groupList: Results<Group> = try! Realm().objects(Group.self)
    //private var filteredGroup: Results<Group> = try! Realm().objects(Group.self)
    //var filteredGroup = ""
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
    
//    func filterGroups(with text: String) {
//
//        filteredGroup = realm.objects(Group.self).filter("ANY groupName CONTAINS %@", [groupList])
//
//        tableView.reloadData()
//    }
    
    
    
    @objc func dissmissKeyboard() {
        view.endEditing(true)
    }
    
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return filteredGroup.count
        return groupList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupCell.reuseId, for: indexPath) as? GroupCell else { fatalError("Cell cannot be dequeued") }
        
//        cell.nameGroupLabel.text = filteredGroup[indexPath.row].groupName
//        cell.myGroupImage.kf.setImage(with: URL(string: filteredGroup[indexPath.row].groupImage))
        
        cell.nameGroupLabel.text = groupList[indexPath.row].groupName
        cell.myGroupImage.kf.setImage(with: URL(string: groupList[indexPath.row].groupImage))
    
        return cell
    }
    
}

extension GroupsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            //filteredGroup = groupList
            view.endEditing(true)
            tableView.reloadData()
            return
        }
        //filterGroups(with: searchText)
        }
}
