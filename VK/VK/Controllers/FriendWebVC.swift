//
//  FriendWebVC.swift
//  VK
//
//  Created by Мас on 14/06/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class FriendWebVC: UIViewController {
    
    let networkingService = NetworkingService(token: Account.shared.token ?? "")
    var friendsDictionary = [String : [String]]()
    var friendsSectionTitles = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
