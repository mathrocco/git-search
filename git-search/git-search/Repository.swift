//
//  Repository.swift
//  git-search
//
//  Created by Matheus Rocco Ferreira on 05/11/16.
//  Copyright © 2016 Rocco. All rights reserved.
//

import UIKit

class Repository: NSObject {

    // Repository properties
    var fullName: String?
    var language: String?
    var repositoryDescription: String?
    var forksCount: Int?
    var stars: Int?
    
    init(fullName: String?, language: String?, repositoryDescription: String?, forksCount: Int?, stars: Int?) {
        self.fullName = fullName
        self.language = language
        self.repositoryDescription = repositoryDescription
        self.forksCount = forksCount
        self.stars = stars
    }
    
}

