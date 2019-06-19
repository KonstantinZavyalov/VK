//
//  NetworkingService.swift
//  VK
//
//  Created by Мас on 12/06/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkingService {
    
    private let baseUrl = "https://api.vk.com"
    let token = Account.shared.token
    let userId = Account.shared.userId
    
    // MARK: - Load VKgroup
    public func userGroups(completion: ((Swift.Result<[Group], Error>) -> Void)? = nil) {
        
        let baseURL = "https://api.vk.com"
        let path = "/method/groups.get"
        
        let params: Parameters = [
            "access_token" : token,
            "extended" : "1",
            "v" : "5.95"
        ]
        Alamofire.request(baseURL + path, method: .get, parameters: params).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let groups = json["response"]["items"].arrayValue.map {Group($0)}
                completion?(.success(groups))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
    
    // MARK: - Search VKgroup
    public func findGroups(_ searchingGroup: String, completion: ((Swift.Result<[Group], Error>) -> Void)? = nil) {
        
        let baseURL = "https://api.vk.com"
        let path = "/method/groups.search"
        
        let params: Parameters = [
            "access_token" : token,
            "q" : searchingGroup,
            "type" : "group",
            "v" : "5.95"
        ]
        
        Alamofire.request(baseURL + path, method: .get, parameters: params).responseJSON {
            response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let groupList = json["response"]["items"].arrayValue.map { Group($0) }
                completion?(.success(groupList))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
    
    // MARK: - Load VKfriends
    public func loadFriends(completion: ((Swift.Result<[FriendProfile], Error>) -> Void)? = nil) {
        
        let baseURL = "https://api.vk.com"
        let path = "/method/friends.get"
        
        let params: Parameters = [
            "access_token" : token,
            "fields" : "nickname,domain,sex,bdate,city,country,photo_50,photo_100,photo_200_orig,online,relation",
            "v" : "5.95"
        ]
        
        Alamofire.request(baseURL + path, method: .get, parameters: params).responseJSON {
            response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let friendList = json["response"]["items"].arrayValue.map { FriendProfile($0) }
                completion?(.success(friendList))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
    
    // MARK: - Load Friend photo
    public func loadPhotos(_ userID: Int, completion: ((Swift.Result<[FriendProfilePhoto], Error>) -> Void)? = nil) {
        
        let baseURL = "https://api.vk.com"
        let path = "/method/photos.getAll"
        
        let params: Parameters = [
            "access_token" : token,
            "owner_id" : userID,
            "count" : "100",
            "v" : "5.95"
        ]
        
        Alamofire.request(baseURL + path, method: .get, parameters: params).responseJSON {
            response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let photoList = json["response"]["items"].arrayValue.map { FriendProfilePhoto($0) }
                completion?(.success(photoList))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
    
}
