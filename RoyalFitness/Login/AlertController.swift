//
//  AlertController.swift
//  RoyalFitness
//
//  Created by Nelson Andrade on 5/12/20.
//  Copyright © 2020 Nelson Andrade. All rights reserved.
//

import UIKit

class AlertController {
    static func showALert(inViewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        
        inViewController.present(alert, animated: true, completion: nil )
    }
}
