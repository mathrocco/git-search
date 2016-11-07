//
//  Search.swift
//  git-search
//
//  Created by Matheus Rocco Ferreira on 05/11/16.
//  Copyright © 2016 Rocco. All rights reserved.
//

import UIKit
import Foundation

class Search: NSObject {
    
    
    static func findUserWithName(_ name: String, completion: @escaping (_ success: Bool, _ users: [User]?) -> Void) {
        
        // base url for user search on git API
        let baseUrl = "https://api.github.com/search/users?q=" + name
        
        // search and the create the user objects
        performSearch(baseUrl: baseUrl) {
            (success, json) in
            
            if(success) {
            
                // get items from json reponse and build the array of users
                if let items = json?["items"] as? Array<[String:AnyObject]> {
                    
                    var usersArray: [User] = []
                    
                    for item in items {
                        print(item)
                        let login = item["login"] as? String
                        let avatar_url = item["avatar_url"] as? String
                        let score = item["score"] as? Int
    
                        let newUser = User(login: login, avatar_url: avatar_url, score: score!)
    
                        usersArray += [newUser]
                    }
                    
                    // callback to completion
                    completion(success, usersArray)
                }
                    
            }
            
        }
        
    }
    
    static func findRepositoryWithName(_ name: String, completion: @escaping (_ success: Bool, _ repositories: [Repository]?) -> Void) {
        
        // base url for repository search on git API
        let baseUrl = "https://api.github.com/search/repositories?q=" + name
        
        // search and the create the repository objects
        performSearch(baseUrl: baseUrl) {
            (success, json) in
            
            if(success) {
                
                // get items from json reponse and build the array of repositories
                if let items = json?["items"] as? Array<[String:AnyObject]> {
                
                    var repositories: [Repository] = []

                    for item in items {
                        print(item)
                        let fullName = item["full_name"] as? String
                        let language = item["language"] as? String
                        let description = item["description"] as? String
                        let forksCount = item["forks_count"] as? Int
                        let stars = item["stargazers_count"] as? Int
                        
                        let newRepository = Repository(fullName: fullName, language: language, repositoryDescription: description, forksCount: forksCount, stars: stars)
                        
                        repositories += [newRepository]
                    }
                    
                    // callback to completion
                    completion(success, repositories)
                }
                
            }
            
        }
        
    }

    // Perform search on passed url and serializes json, returning a dictionary
    static private func performSearch(baseUrl: String, completion: @escaping (_ success: Bool, _ json: [String: AnyObject]?) -> Void) {
        
        guard let url = URL(string: baseUrl) else {
            print("Error: cannot create URL")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on /todos/1")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                    print("error trying to convert data to JSON")
                    return
                }
                
                
                // jsonReponse is a dictionary, so we can access it from its key
                guard let count = jsonResponse["total_count"] as? Int else {
                    print("Could not get todo title from JSON")
                    return
                }
                print("Number of responses: " + String(count))
                
                completion(true, jsonResponse)
            } catch  {
                print("error trying to convert data to JSON")
                completion(false, nil)
            }
        }
        task.resume()
    }
}
