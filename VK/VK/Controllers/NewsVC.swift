//
//  NewsVC.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 26/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class NewsVC: UIViewController, UITableViewDataSource {
    

    public var newspapper: [News] = [
        News(avatarImageView: UIImage(named: "Swift")!, nameGroup: "Swift", descript: "Сегодня мы ввели нововведения!")
    ]
    
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newspapper.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseId, for: indexPath) as? NewsCell else { fatalError() }
        
        if let image = newspapper[indexPath.row].avatarImageView {
            cell.avatarImageView.image = image
        }
        cell.nameGroupLabel.text = newspapper[indexPath.row].nameGroup
        cell.descriptionLabel.text = newspapper[indexPath.row].description
//        if let image = newspapper[indexPath.row].addDescriptionImageView {
//            cell.addDescriptionImageView.image = image
//        }
        
        return cell
    }

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
