//
//  UserDetailsViewController.swift
//  AgaHub
//
//  Created by Agnieszka Duch on 02/02/2020.
//  Copyright © 2020 Agnieszka Duch. All rights reserved.
//

import UIKit

class UserDetailsViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    var favouriteUsers = [String]()

    private let dataManager = DataManager()
    private var users = [UserDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationItem.hidesBackButton = true
        fetchUsers()
    }
    
    @IBAction func logoutButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private
    private func fetchUsers() {
        
        dataManager.performRequest(url: Constants.userDetailsURL) { response, error in
            
            if let array = response?.array {
                for json in array {
                    self.users.append(UserDetails(json: json))
                }
            }
            self.tableView.reloadData()
        }
    }
    @IBAction func favouriteButton(_ sender: UIButton) {
        
        //not working?
//        favouriteUsers.append(users[sender.].login)
//        UserDefaults.setValue(<#T##value: Any?##Any?#>, forKey: <#T##String#>)
        sender.imageView?.image = UIImage.init(named: Constants.favouriteImage)?
            .withTintColor(.white)
        
    }
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userDetailsCell", for: indexPath) as! UserTableViewCell
        cell.updateUI(with: self.users[indexPath.row])
        return cell
    }
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if let safeUrl = users[indexPath.row].html_url {
            UIApplication.shared.open(URL(string: safeUrl)!, options: [:], completionHandler: nil)
        }
    }
}
