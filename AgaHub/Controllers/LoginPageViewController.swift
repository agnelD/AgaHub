//
//  LoginPageViewController.swift
//  AgaHub
//
//  Created by Agnieszka Duch on 02/02/2020.
//  Copyright © 2020 Agnieszka Duch. All rights reserved.
//

import UIKit

class LoginPageViewController: UIViewController, UITextFieldDelegate {
    
    let username = "iloveios"
    let password = "hiremenow"

    @IBOutlet weak var usernameTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextfield.delegate = self
        passwordTextfield.delegate = self
        
//        is there a better way for dismissing a keyboard?
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGesture)

    }

    @IBAction func logInButtonPressed(_ sender: UIButton) {
        
        if usernameTextfield.text == username && passwordTextfield.text == password {
            
//   go to details screen
            
            performSegue(withIdentifier: "goToUserDetails", sender: self)
            
        } else {
            usernameTextfield.text = ""
            passwordTextfield.text = ""
            usernameTextfield.placeholder = "Invalid username or password"
            passwordTextfield.placeholder = "Invalid username or password"
        }
    }
//MARK: - Textfield delegate methods
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        usernameTextfield.resignFirstResponder()
        passwordTextfield.resignFirstResponder()
    }
}

