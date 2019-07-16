//
//  News.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 26/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import SwiftyJSON

struct News {
    
    let textNewsLabel: String
    let likeCounts: Int
    let newsPhotos: String
    
    init(_ json: JSON) {
        textNewsLabel = json["text"].stringValue
        likeCounts = json["likes"]["count"].intValue
        newsPhotos = json["attachments"][0]["photo"]["sizes"][3]["url"].stringValue
    }
}
