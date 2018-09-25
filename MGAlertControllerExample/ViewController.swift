//
//  ViewController.swift
//  MGAlertControllerExample
//
//  Created by Mayur G on 25/09/18.
//  Copyright © 2018 Mayur G. All rights reserved.
//

import UIKit
import MGAlertController

class ViewController: UIViewController {

    @IBOutlet weak var numberOfAlertLabel: UILabel!
    
    private var numberOfAlerts: Int {
        return Int(numberOfAlertLabel.text ?? "") ?? 0
    }

    // MARK:- IBActions
    
    @IBAction func onShowTap(_ sender: UIButton) {
        for i in 1...numberOfAlerts {
            let alertController = MGAlertController(title: "Alert - \(i)", message: "Message(\(i)) goes here")
            alertController.addAction(title: "OK")
            alertController.show()
        }
    }
    
    @IBAction func onAddTap(_ sender: UIButton) {
        if numberOfAlerts < 10 {
            numberOfAlertLabel.text = String(numberOfAlerts + 1)
        }
    }
    
    @IBAction func onRemoveTap(_ sender: UIButton) {
        if numberOfAlerts > 1 {
            numberOfAlertLabel.text = String(numberOfAlerts - 1)
        }
    }
    
}

