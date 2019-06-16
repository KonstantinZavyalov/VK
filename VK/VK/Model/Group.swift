//
//  Group.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 10/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Group: Object, DipslayableGroup {
    @objc dynamic var groupName: String = ""
    @objc dynamic var groupImage: String = ""
    
    convenience init(groupName: String, groupImage: String) {
        self.init()
        self.groupName = groupName
        self.groupImage = groupImage
    }
    
    convenience init(_ json: JSON) {
        self.init()
        
        self.groupName = json["name"].stringValue
        self.groupImage = json["photo_200"].stringValue
    }
}
