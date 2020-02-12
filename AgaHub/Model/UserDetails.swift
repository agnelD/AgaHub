//
//  UserDetails.swift
//  AgaHub
//
//  Created by Agnieszka Duch on 02/02/2020.
//  Copyright © 2020 Agnieszka Duch. All rights reserved.
//

import UIKit
import SwiftyJSON

struct UserDetails {
    let login: String?
    let avatar_url: String?
    let html_url: String?
    
    init(json: JSON) {
        login = json["login"].string
        avatar_url = json["avatar_url"].string
        html_url = json["html_url"].string
    }
}
