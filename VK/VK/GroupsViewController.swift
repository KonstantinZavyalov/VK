//
//  GroupsViewController.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 08/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class GroupsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    public var groups: [Group] = [
        Group(name: "Swift", groupImageView: UIImage(named: "Swift")),
        Group(name:"Objective-C", groupImageView: UIImage(named: "Objective_c")),
        Group(name: "Python", groupImageView: UIImage(named: "Python")),
        Group(name: "Go", groupImageView: UIImage(named: "Golang"))
    ]
    var filterGroups = [Group]()
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        filterGroups = groups
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filterGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupCell.reuseId, for: indexPath) as? GroupCell else { fatalError("Cell cannot be dequeued") }
        
        cell.nameGroupLabel.text = filterGroups[indexPath.row].name
        if let image = filterGroups[indexPath.row].groupImageView {
            cell.myGroupImage.image = image
        }
        return cell
    }
    
    private func filterGroups(with text: String) {
        filterGroups = groups.filter( {Group -> Bool in
            return Group.name.lowercased().contains(text.lowercased())
        })
    }
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Delete the row from the data source
            let group = filterGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            if let index = groups.firstIndex(where: { $0.name == group.name }) {
                groups.remove(at: index)
            }
        }
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        
        if let groupMoreTVC = segue.source as? GroupMoreTVC,
            let indexPath = groupMoreTVC.tableView.indexPathForSelectedRow {
            let newGroup = groupMoreTVC.groupsMore[indexPath.row]
            
            guard !groups.contains(where: { group -> Bool in
                return group.name == newGroup.name
            }) else { return }
            
            self.groups.append(newGroup)
            filterGroups.append(newGroup)
            let newIndexPath = IndexPath(item: filterGroups.count-1, section: 0)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            tableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filterGroups = groups
            tableView.reloadData()
            return
        }
        
        filterGroups(with: searchText)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    }
    
}
