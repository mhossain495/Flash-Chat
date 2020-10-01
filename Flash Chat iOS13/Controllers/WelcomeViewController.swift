//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Mohammed Hossain on 21/09/2020.


import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = K.appName
        
    }
}
