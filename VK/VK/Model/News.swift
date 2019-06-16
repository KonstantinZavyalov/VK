//
//  News.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 26/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import RealmSwift

class News: Object {
    @objc dynamic var avatarImageView: UIImage?
    @objc dynamic var nameGroup: String = ""
    @objc dynamic var descript: String = ""
    
    convenience init(avatarImageView: UIImage, nameGroup: String, descript: String) {
        self.init()
        self.avatarImageView = avatarImageView
        self.nameGroup = nameGroup
        self.descript = descript
    }

}
