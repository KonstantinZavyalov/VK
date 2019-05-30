//
//  LoginWebVC.swift
//  VK
//
//  Created by Мас on 30/05/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

class LoginWebVC: UIViewController {
    
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "oauth.vk.com"
        components.path = "/authorize"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: "6995632"),
            URLQueryItem(name: "scope", value: "262158"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.95")
        ]
        
        let request = URLRequest(url: components.url!)
        webView.load(request)
    }
    
    static let session: SessionManager = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60
        let session = SessionManager(configuration: config)
        return session
    }()
    
    func loadGroups(token: String) {
        let baseUrl = "https://api.vk.com"
        let pathFriends = "/method/friends.get"
        let pathPhotos = "/method/photos.getAll"
        let pathGroups = "/method/groups.get"
        let pathGroupsSearch = "/method/groups.search"
        let search = "?q=Neftekamsk"
        
        
        let params: Parameters = [
            "access_token": token,
            "extended": 1,
            "v": "5.95"
        ]

        LoginWebVC.session.request(baseUrl + pathFriends, method: .get, parameters: params).responseJSON
            { response in
            guard let jsonFriends = response.value else { return }

            print(jsonFriends)
        }

        LoginWebVC.session.request(baseUrl + pathPhotos, method: .get, parameters: params).responseJSON
            { response in
                guard let jsonPhotos = response.value else { return }

                print(jsonPhotos)
        }

        LoginWebVC.session.request(baseUrl + pathGroups, method: .get, parameters: params).responseJSON
            { response in
            guard let jsonGroups = response.value else { return }

            print(jsonGroups)
        }

        LoginWebVC.session.request(baseUrl + pathGroupsSearch + search, method: .get, parameters:                                         params).responseJSON
            { response in
                guard let jsonGroupsSearch = response.value else { return }
                
                print(jsonGroupsSearch)
        }
    }
    
}

extension LoginWebVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment else { decisionHandler(.allow); return }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        print(params)
        
        guard let token = params["access_token"],
            let userIdString = params["user_id"],
            let userId = Int(userIdString) else {
                decisionHandler(.allow)
                return
        }
        
        Session.instance.token = token
        Session.instance.userId = userId
        // performSegue(withIdentifier:)
        
        LoginWebVC().loadGroups(token: token)
        
        decisionHandler(.cancel)
    }
}
