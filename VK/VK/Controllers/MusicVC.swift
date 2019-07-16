//
//  MusicVC.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 17/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import AVKit

class MusicVC: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    
    func playSound() {
        do {
            self.audioPlayer =  try AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: "Александр Маршал - Счастье", ofType: "mp3")!) as URL)
            self.audioPlayer.play()
            
        } catch {
            print("Error")
        }
    }
    
    @IBAction func playButton(_ sender: Any) {
        
        let pulse =  CASpringAnimation(keyPath: "transform.scale")
            pulse.duration =  0.3
            pulse.fromValue = 0.95
            pulse.toValue = 1.0
            pulse.initialVelocity = 0.1
            pulse.damping = 1.0
        
        (sender as AnyObject).layer.add(pulse, forKey: "pulse")
        playSound()
    }
    @IBAction func pauseBatton(_ sender: Any) {
        
        let pulse =  CASpringAnimation(keyPath: "transform.scale")
        pulse.duration =  0.3
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.initialVelocity = 0.1
        pulse.damping = 1.0
        
        (sender as AnyObject).layer.add(pulse, forKey: "pulse")
        audioPlayer.pause()
    }
    
    @IBAction func helpButton(_ sender: Any) {
        let alertController = UIAlertController(title: "VK:", message: "С 16 декабря 2016 года мы отключаем публичный API для работы с аудиозаписями.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Блин 😔", style: .default) { (actoin) in }
        
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}


