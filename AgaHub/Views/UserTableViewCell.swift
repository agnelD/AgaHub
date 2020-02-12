//
//  UserTableViewCell.swift
//  AgaHub
//
//  Created by Agnieszka Duch on 08/02/2020.
//  Copyright © 2020 Agnieszka Duch. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet var loginLabel: UILabel!
    
//    func update(with user: UserDetails) {
//        loginLabel.text = user.login
//    }
//
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    
    func updateUI(with user: UserDetails) {
        loginLabel.text = user.login
        accountLabel.text = user.html_url
        
        let data = try? Data(contentsOf: URL(string: user.avatar_url!)!)

        if let imageData = data {
            avatarImage.image = UIImage(data: imageData)
        }
}
}
