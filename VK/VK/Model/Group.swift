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

@objcMembers
class Group: Object {
    dynamic var id: Int = 0
    dynamic var groupName: String = ""
    dynamic var groupImage: String = ""
    
    convenience init(_ json: JSON) {
        self.init()
        
        self.id = json["id"].intValue
        self.groupName = json["name"].stringValue
        self.groupImage = json["photo_200"].stringValue
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
