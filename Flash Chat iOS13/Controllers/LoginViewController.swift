//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Mohammed Hossain on 21/09/2020.


import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                //guard self == nil else { return }
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    self?.performSegue(withIdentifier: "LoginToChat", sender: self)
                }
                
            }
            
        }
        
    }
}
