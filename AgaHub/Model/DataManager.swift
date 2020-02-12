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
    
    let baseURL = "https://github.com"
    
    func performRequest(url: String, completion: @escaping (JSON?, Error?) -> Void) {
        
        AF.request(url, method: .get).responseJSON { response in
            switch response.result {
            case .success(let value):
                completion(JSON(value), nil)
//                let json =
//                let login = .arrayValue.map{$0["login"].stringValue}
//                let avatarUrlArray = JSON(value).arrayValue.map{$0["avatar_url"].stringValue}
//                //            let reposUrlArray = loginArray.map{"\(baseURL)\" + (loginArray}
//                //            let reposURL = "\(self.baseURL)/\(loginArray[0])/?tab=repositories"
//                //            let reposURLArray = loginArray.map{"\(self.baseURL)/\(loginArray[$0 as NSNumber])/?tab=repositories"}
//
//                var reposURLArray = [String]()
//                for i in (0...loginArray.count-1) {
//                    let newlogin = "\(self.baseURL)/\(loginArray[i])/?tab=repositories"
//                    reposURLArray.append(newlogin)
//                }
//
//                print("JSON: \(loginArray)")
//                print("JSON: \(avatarUrlArray)")
//                print("JSON: \(reposURLArray)")
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
