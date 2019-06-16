//
//  Session.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 18/05/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation

class Session {
    private init() { }
    
    public static let shared = Session()
    var token: String?
    var userId: Int?
}
