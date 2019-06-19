//
//  Frends.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 10/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift

@objcMembers
class FriendProfile: Object {
    
    dynamic var userid: Int = 0
    dynamic var name: String = ""
    dynamic var lastname: String = ""
    dynamic var avatarImage: String = ""
    
    convenience init(_ json: JSON) {
        self.init()
        
        self.userid = json["id"].intValue
        self.name = json["first_name"].stringValue
        self.lastname = json["last_name"].stringValue
        self.avatarImage = json["photo_200_orig"].stringValue
    }
    
    override static func primaryKey() -> String? {
        return "userid"
    }
}

@objcMembers
class FriendProfilePhoto: Object {
   
    dynamic var userid: Int = 0
    dynamic var photo: String = ""
    
    convenience init(_ json: JSON) {
        self.init()
        self.userid = json["owner_id"].intValue
        self.photo = json["sizes"][3]["url"].stringValue
    }
    
    override static func primaryKey() -> String? {
        return "photo"
    }
}
