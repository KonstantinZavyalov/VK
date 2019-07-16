//
//  NewsVC.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 26/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import Kingfisher

class NewsVC: UIViewController, UITableViewDataSource {
    
    let request = NetworkingService()
    public var newsList: [News] = []
    
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        request.loadNews() { result in
            switch result {
            case .success(let newsList):
                self.newsList = newsList
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return newsList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseId, for: indexPath) as? NewsCell else { fatalError() }
        
        if newsList[indexPath.row].textNewsLabel != "" {
            cell.textNewsLabel.text = String(newsList[indexPath.row].textNewsLabel)
        }
        cell.likeCountLabel.text = String(newsList[indexPath.row].likeCounts)
        cell.imageNewsView.kf.setImage(with: URL(string: newsList[indexPath.row].newsPhotos))
        
        return cell
    }
    
    //MARK: активные кнопки под новостями
    
    // Репост
    @IBAction func repostButton(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let actionFrends = UIAlertAction(title: "Рассказать друзьям", style: .default) { (actoin) in }
        let actionGroup = UIAlertAction(title: "Опубликовать в сообществе", style: .default)
        let actionMassage = UIAlertAction(title: "Отправить сообщением", style: .default)
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel)
        
        alertController.addAction(actionFrends)
        alertController.addAction(actionGroup)
        alertController.addAction(actionMassage)
        alertController.addAction(actionCancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Комментарий
    @IBAction func comentButton(_ sender: Any) {
        let alertController = UIAlertController(title: "💬💬💬", message: "Напишите свой комментарий", preferredStyle: .alert)
        let actionComent = UIAlertAction(title: "Поделится", style: .default) { (actoin) in
            let text = alertController.textFields?.first?.text
            print(text ?? "nill text")
        }
        
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(actionComent)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
