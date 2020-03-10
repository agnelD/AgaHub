//
//  DataManager.swift
//  AgaHub
//
//  Created by Agnieszka Duch on 02/02/2020.
//  Copyright © 2020 Agnieszka Duch. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DataManager {
        
    func performRequest(url: String, completion: @escaping (JSON?, Error?) -> Void) {
        
        Alamofire.request(url, method: .get).responseJSON { response in
            switch response.result {
            case .success(let value):
                completion(JSON(value), nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
