//
//  Account.swift
//  VK
//
//  Created by Мас on 12/06/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation

class Account {
    private init() { }
    
    public static let shared = Account()
    var token: String = ""
    var userId: Int = 0
}
