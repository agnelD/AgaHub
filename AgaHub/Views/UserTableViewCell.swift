//
//  UserTableViewCell.swift
//  AgaHub
//
//  Created by Agnieszka Duch on 08/02/2020.
//  Copyright © 2020 Agnieszka Duch. All rights reserved.
//
import UIKit
import SDWebImage

protocol UserTableViewCellDelegate: class {
    func userTableViewCellFavouriteButtonTapped(for indexPath: IndexPath)
}

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var starButton: UIButton!
    weak var delegate: UserTableViewCellDelegate?
    var indexPath: IndexPath!
    
    @IBAction func favouriteButton(_ sender: UIButton) {
        delegate?.userTableViewCellFavouriteButtonTapped(for: indexPath)
    }
    
    func updateUI(with user: UserDetails, favouritedUsers: [String]) {
        loginLabel.text = user.login
        accountLabel.text = user.html_url
        avatarImage.sd_setImage(with: URL(string: user.avatar_url ?? ""), completed: nil)
        if favouritedUsers.contains(user.login ?? "") {
            starButton.setImage(UIImage(systemName: Constants.favouriteImage), for: .normal)
        } else {
            starButton.setImage(UIImage(systemName: Constants.non_favouriteImage), for: .normal)
        }
    }
}
