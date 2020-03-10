//
//  LoginPageViewController.swift
//  AgaHub
//
//  Created by Agnieszka Duch on 02/02/2020.
//  Copyright © 2020 Agnieszka Duch. All rights reserved.
//

import UIKit

class LoginPageViewController: UIViewController, UITextFieldDelegate {
    
    private let defaults = UserDefaults.standard
    private let dataManager = DataManager()
    private var userCredentials = [String]()
    
    @IBOutlet private weak var usernameTextfield: UITextField!
    @IBOutlet private weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "credentials") as? [String] {
            userCredentials = items
        }
        
        usernameTextfield.delegate = self
        passwordTextfield.delegate = self
        //        usernameTextfield.text = "iloveios"
        //        passwordTextfield.text = "hiremenow"
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        navigationController?.navigationBar.barTintColor = .white
        
        if !userCredentials.isEmpty {
            performSegue(withIdentifier: Constants.userDetailsSegue, sender: self)
        } else {
            return
        }
    }
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        
        if usernameTextfield.text == Constants.username && passwordTextfield.text == Constants.password {
            
            performSegue(withIdentifier: Constants.userDetailsSegue, sender: self)
            
            if let safeUsername = usernameTextfield.text, let safePassword = passwordTextfield.text {
                userCredentials.append(safeUsername)
                userCredentials.append(safePassword)
            }
            
            defaults.set(self.userCredentials, forKey: "credentials")
            
            usernameTextfield.text = ""
            passwordTextfield.text = ""
            
        } else {
            usernameTextfield.text = ""
            passwordTextfield.text = ""
            
            let alert = UIAlertController(title: "Invalid username or password", message: "Please try again", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
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
