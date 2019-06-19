//
//  GroupResponse.swift
//  VK
//
//  Created by Мас on 16/06/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation

// MARK: - VKResponse
struct VKResponse: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let count: Int
    let items: [CodableGroup]
}

// MARK: - Item
struct CodableGroup: Codable, DipslayableGroup {
    let id: Int
    let name, screenName: String
    let isClosed: Int
    let type: TypeEnum
    let isAdmin, isMember, isAdvertiser: Int
    let photo50, photo100, photo200: String
    
    var groupName: String {
        return name
    }
    var groupImage: String {
        return photo100
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case isAdmin = "is_admin"
        case isMember = "is_member"
        case isAdvertiser = "is_advertiser"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }
}

enum TypeEnum: String, Codable {
    case event = "event"
    case group = "group"
    case page = "page"
}

protocol DipslayableGroup {
    var groupName: String { get }
    var groupImage: String { get }
}
