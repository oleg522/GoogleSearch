//
//  UIViewController.swift
//  GoogleSearch
//
//  Created by Oleg Bakatin on 16.02.2020.
//  Copyright © 2020 Oleg Bakatin. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title: String = "", message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            action.setValue(UIColor.black, forKey: "titleTextColor")
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
}
