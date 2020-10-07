//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Mohammed Hossain on 21/09/2020.


import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    // Hide navigation bar in welcome screen before current view is displayed
    // Use super when overriding superclass function
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(<#T##animated: Bool##Bool#>)
        navigationController?.isNavigationBarHidden = true
    }
    
    // Load navigation bar; Called before view is removed from hierarchy
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(<#T##animated: Bool##Bool#>)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = K.appName
    }
}
