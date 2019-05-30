//
//  MoreGroupVC.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 13/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class MoreGroupVC: UIViewController, UITableViewDataSource {

    public var groups: [Group] = [
        Group(name: "Python 🐍"),
        Group(name: "Go 🏃‍♂️"),
        Group(name: "Android 🐸"),
        Group(name: "Java ☕️")
    ]
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupMoreCell.reuseId, for: indexPath) as? GroupMoreCell else { fatalError("Cell cannot be dequeued") }
        
        cell.nameGroupMoreLabel.text = groups[indexPath.row].name
        
        return cell
    }
    
    
}
