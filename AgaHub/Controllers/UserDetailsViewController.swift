//
//  UserDetailsViewController.swift
//  AgaHub
//
//  Created by Agnieszka Duch on 02/02/2020.
//  Copyright © 2020 Agnieszka Duch. All rights reserved.
//

import UIKit
import SVProgressHUD
class UserDetailsViewController: UITableViewController, UserTableViewCellDelegate {
    
    let defaults = UserDefaults.standard
    var favouriteUsers = [String]()

    private let dataManager = DataManager()
    private var users = [UserDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationItem.hidesBackButton = true
        fetchUsers()
        favouriteUsers = defaults.stringArray(forKey: "favouritedUsers") ?? []
    }
    
    @IBAction func logoutButton(_ sender: UIBarButtonItem) {
        defaults.removeObject(forKey: "credentials")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Private
    private func fetchUsers() {
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.setContainerView(view)
        SVProgressHUD.show(withStatus: "sciagma to teraz. niE PRZESZKADZAJ")
        dataManager.performRequest(url: Constants.userDetailsURL) { response, error in

            if let array = response?.array {
                for json in array {
                    self.users.append(UserDetails(json: json))
                }
            }
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
        }
    }
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userDetailsCell", for: indexPath) as! UserTableViewCell
        cell.updateUI(with: self.users[indexPath.row], favouritedUsers: favouriteUsers)
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if let safeUrl = users[indexPath.row].html_url {
            UIApplication.shared.open(URL(string: safeUrl)!, options: [:], completionHandler: nil)
        }
    }
    // MARK: - UserTableViewCellDelegate
    func userTableViewCellFavouriteButtonTapped(for indexPath: IndexPath) {
        let user = users[indexPath.row]
        print("+++++++ \(favouriteUsers) +++++")
        if favouriteUsers.contains(user.login ?? "") {
            if let index = favouriteUsers.firstIndex(of: user.login ?? "") {
                favouriteUsers.remove(at: index)
            }
        } else {
            favouriteUsers.append(user.login ?? "")
        }
        defaults.set(favouriteUsers, forKey: "favouritedUsers")
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}
