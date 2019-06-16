//
//  GroupMoreTVC.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 14/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import Kingfisher

class GroupMoreTVC: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    var searchingText = "Something"
    let request = NetworkingService()
    public var groupList = [Group]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        view.addGestureRecognizer(tapGR)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groupList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupMoreCell.reuseId, for: indexPath) as? GroupMoreCell else { fatalError() }
        
        cell.nameGroupMoreLabel.text = groupList[indexPath.row].groupName
        cell.groupsImage.kf.setImage(with: URL(string: groupList[indexPath.row].groupImage))
        
        return cell
    }
    
    // MARK: - Helpers
    @objc func dissmissKeyboard() {
        view.endEditing(true)
    }
    
}

extension GroupMoreTVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            groupList.removeAll()
            view.endEditing(true)
            tableView.reloadData()
            return
        }
        request.findGroups(searchText) { result in
            switch result {
            case .success(let groupList):
                self.groupList.removeAll()
                self.groupList = groupList
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
