//
//  GroupsViewController.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 08/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import Kingfisher

class GroupsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let request = NetworkingService()
    private var groupList = [CodableGroup]()
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    private var filteredGroupList = [CodableGroup]()
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        request.userGroups { result in
            switch result {
            case .success(let groupList):
                self.groupList = groupList
                self.filteredGroupList = self.groupList
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        view.addGestureRecognizer(tapGR)
    }
    
    private func filterGroups(with text: String) {
        filteredGroupList = groupList.filter { group in
            return group.groupName.lowercased().contains(text.lowercased())
        }
        tableView.reloadData()
    }
    
    @objc func dissmissKeyboard() {
        view.endEditing(true)
    }
    
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredGroupList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupCell.reuseId, for: indexPath) as? GroupCell else { fatalError("Cell cannot be dequeued") }
        
        cell.nameGroupLabel.text = filteredGroupList[indexPath.row].groupName
        cell.myGroupImage.kf.setImage(with: URL(string: filteredGroupList[indexPath.row].groupImage))
        
        return cell
    }
    
}

extension GroupsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredGroupList = groupList
            view.endEditing(true)
            tableView.reloadData()
            return
        }
        filterGroups(with: searchText)
    }
}
