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
final class Friend: Object {
    
    dynamic var id: Int = 0
    dynamic var firstname: String = ""
    dynamic var lastname: String = ""
    dynamic var friendname: String = ""
    dynamic var avatar: String = ""
    dynamic var city: String = ""
    dynamic var state: Int = 0
    dynamic var gender: Int = 0
    
    convenience init(id: Int, firstname: String, lastname: String, avatar: String) {
        self.init()
        self.id = id
        self.firstname = firstname
        self.lastname = lastname
        self.avatar = avatar
    }
    
    convenience init(_ json: JSON) {
        self.init()
        
        self.id = json["id"].intValue
        self.firstname = json["first_name"].stringValue
        self.lastname = json["last_name"].stringValue
        self.friendname = "\(firstname) \(lastname)"
        self.avatar = json["photo_100"].stringValue
        self.city = json["city"]["title"].stringValue
        self.state = json["online"].intValue
        self.gender = json["sex"].intValue
    }
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

@objcMembers
class FriendProfilePhoto: Object {
   
    dynamic var userid: Int = 0
    dynamic var photo: String = ""
    
    convenience init(userid: Int, photo: String) {
        self.init()
        self.userid = userid
        self.photo = photo
    }
    
    convenience init(_ json: JSON) {
        self.init()
        self.userid = json["owner_id"].intValue
        self.photo = json["sizes"][3]["url"].stringValue
    }
    
    override static func primaryKey() -> String? {
        return "photo"
    }
}
