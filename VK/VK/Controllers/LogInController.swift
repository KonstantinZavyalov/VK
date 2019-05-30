//
//  LogInController.swift
//  VK (Zavyalov Konstantin)
//
//  Created by Мас on 01/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class LogInController: UIViewController {
    
    //MARK: - Properties
    let dotsView = LoadingAnimationView()
    //let appleView = AppleAnimation()
    
    //MARK: - Outlets
    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    
    
    //MARK: - Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(tapGR)
        
        view.addSubview(dotsView)
        //view.addSubview(appleView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dotsView.frame = CGRect(x: 155, y: 690, width: 99, height: 33)
        dotsView.startAnimating()
//        appleView.frame = CGRect(x: 155, y: 723, width: 99, height: 99)
//        appleView.startAnimating()
    }
    
    //MARK: - Actions
    @IBAction func TapAnimationLogoButton(_ sender: Any) {

            let pulse =  CASpringAnimation(keyPath: "transform.scale")
            pulse.duration =  0.2
            pulse.fromValue = 0.95
            pulse.toValue = 1.0
            pulse.autoreverses = false
            pulse.repeatCount = 0
            pulse.initialVelocity = 0.5
            pulse.damping = 1.0
            
            logoImageView.layer.add(pulse, forKey: "pulse")
    }
    @IBAction func LogInButtonPress(_ sender: UIButton) {
        if usernameInput.text == "",
            passwordInput.text == "" {
            performSegue(withIdentifier: "Show Main Screen", sender: sender)
        } else {
            showLoginError()
        }
    }
    
    @IBAction func PasswordFailButtonPress(_ sender: UIButton) {

        showPasswordError()
    }
    
    //MARK: - Private API 
    @objc func keyboardWasShown(notification: Notification) {
        let info = notification.userInfo as NSDictionary?
        let keybordSize = (info?.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentsInsets = UIEdgeInsets(top: 0, left: 0, bottom: keybordSize.height, right: 0)
        
        scrollView.contentInset = contentsInsets
        scrollView.scrollIndicatorInsets = contentsInsets
    }
    
    @objc func keybordWasHidden(notification: Notification) {
        let contentsInsets = UIEdgeInsets.zero
        
        scrollView.contentInset = contentsInsets
        scrollView.scrollIndicatorInsets = contentsInsets
    }
    
    @objc private func hideKeyboard() {
        scrollView.endEditing(true)
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard identifier == "Show Main Screen" else { return true }
        
        if usernameInput.text == "",
            passwordInput.text == "" {
            return true
        } else {
            let animation = CAKeyframeAnimation(keyPath: "position.x")
            animation.values = [NSNumber(value: 0), NSNumber(value: 20), NSNumber(value: -20), NSNumber(value: 10), NSNumber(value: 0)]
            animation.keyTimes = [NSNumber(value: 0), NSNumber(value: 1 / 6.0), NSNumber(value: 3 / 6.0), NSNumber(value: 5 / 6.0),                         NSNumber(value: 1)]
            animation.duration = 0.4
            animation.isAdditive = true
            
            passwordInput.layer.add(animation, forKey: "shake")
            showLoginError()
            return false
        }
    }
    
    private func showLoginError() {
        let loginAlert = UIAlertController(title: "Неверный логин/пароль 😔", message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Ok", style: .default) { _ in
            self.passwordInput.text = ""
        }
        loginAlert.addAction(action)
        
        present(loginAlert, animated: true)
    }
    
    public func showPasswordError() {
        let passwordAlert = UIAlertController(title: "Забыли пароль?", message: "Там пустые поля, просто нажми войти", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ясно, спасибо!", style: .default) { _ in
            self.passwordInput.text = ""
        }
        passwordAlert.addAction(action)
        
        present(passwordAlert, animated: true)
    }
    
}

