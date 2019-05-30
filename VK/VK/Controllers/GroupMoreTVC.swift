//
//  GroupMoreTVC.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 14/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class GroupMoreTVC: UITableViewController {
    
    public var groupsMore: [Group] = [
        Group(name: "Swift", groupImageView: UIImage(named: "Swift")),
        Group(name:"Objective-C", groupImageView: UIImage(named: "Objective_c")),
        Group(name: "Python", groupImageView: UIImage(named: "Python")),
        Group(name: "Go", groupImageView: UIImage(named: "Golang")),
        Group(name: "Android", groupImageView: UIImage(named: "Android")),
        Group(name: "Java", groupImageView: UIImage(named: "Java"))
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsMore.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupMoreCell.reuseId, for: indexPath) as? GroupMoreCell else { fatalError() }
        
        cell.nameGroupMoreLabel.text = groupsMore[indexPath.row].name
        if let image = groupsMore[indexPath.row].groupImageView {
            cell.groupsImage.image = image
        }
        
        return cell
    }

}
