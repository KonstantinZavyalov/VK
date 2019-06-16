//
//  UIViewController+Ext.swift
//  VK
//
//  Created by Мас on 12/06/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

extension UIViewController {
    func show(_ error: Error) {
        let alertVC = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alertVC.addAction(action)
        present(alertVC, animated: true)
    }
}
