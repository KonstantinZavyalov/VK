//
//  MusicVC.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 17/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class MusicVC: UIViewController, UITableViewDataSource {
    
    public var playList: [Music] = [
        Music(name: "Novella", coverImageView: UIImage(named: "backgraund")!, duration: "03:17"),
        Music(name: "Rockstar", coverImageView: UIImage(named: "backgraund")!, duration: "04:02"),
        Music(name: "Drunk Groove", coverImageView: UIImage(named: "backgraund")!, duration: "03:58"),
        Music(name: "Jonas Brothers", coverImageView: UIImage(named: "backgraund")!, duration: "02:43"),
        Music(name: "Dua Lipa & BLACKPINK", coverImageView: UIImage(named: "backgraund")!, duration: "03:55"),
        Music(name: "Rita Ora", coverImageView: UIImage(named: "backgraund")!, duration: "03:36"),
        Music(name: "Самоучитель Swift 856 издание", coverImageView: UIImage(named: "backgraund")!, duration: "93:56"),
        Music(name: "LP", coverImageView: UIImage(named: "backgraund")!, duration: "04:12"),
        Music(name: "Artik & Asti", coverImageView: UIImage(named: "backgraund")!, duration: "02:38"),
        Music(name: "MARUV", coverImageView: UIImage(named: "backgraund")!, duration: "03:47"),
        Music(name: "Arnon", coverImageView: UIImage(named: "backgraund")!, duration: "03:03")
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
        return playList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MusicCell.reuseId, for: indexPath) as? MusicCell else { fatalError() }
        
        cell.nameMusicLabel.text = playList[indexPath.row].name
        cell.durationLabel.text = playList[indexPath.row].duration
        if let image = playList[indexPath.row].coverImageView {
            cell.coverImageView.image = image
        }
        
        return cell
    }
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            playList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func playErrorButton(_ sender: Any) {
        let alertController = UIAlertController(title: "😔", message: "Прослушивание музыки ограничено. Для снятия ограничения воспользуйтесь подпиской.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Cнять ограничение", style: .default) { (actoin) in }
        let actionTwo = UIAlertAction(title: "Напомнить позже", style: .default)
        
        alertController.addAction(action)
        alertController.addAction(actionTwo)
        self.present(alertController, animated: true, completion: nil)
    }
}


