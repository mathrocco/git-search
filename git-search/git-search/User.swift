//
//  User.swift
//  git-search
//
//  Created by Matheus Rocco Ferreira on 05/11/16.
//  Copyright © 2016 Rocco. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var login: String?
    var avatar_url: String?
    var score: Int?
 
    init(login: String?, avatar_url: String?, score: Int) {
        
        self.login = login
        self.avatar_url = avatar_url
        self.score = score
    }
}
