//
//  UserSearchViewController.swift
//  git-search
//
//  Created by Matheus Rocco Ferreira on 05/11/16.
//  Copyright © 2016 Rocco. All rights reserved.
//

import UIKit

class UserSearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var users: [User] = [] // array of users
    
    var activityIndicator = UIActivityIndicatorView() // activity indicator to give user response
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

//MARK: Search bar delegate methods
extension UserSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        print("Searching for users...")
        
        // get name from searchBar
        let name = searchBar.text
        
        // insert activity activityIndicator
        self.activityIndicator.color = UIColor.gray
        let activityIndicatorFrame = CGRect(x: (self.tableView.frame.width/2)-25, y: (self.tableView.frame.height/2)-25, width: 50, height: 50)
        self.activityIndicator.frame = activityIndicatorFrame
        self.activityIndicator.startAnimating()
        self.tableView.addSubview(self.activityIndicator)
        
        //Search for user
        Search.findUserWithName(name!) { (success, users) in
            if success {
                self.users = users!
                
                DispatchQueue.main.async {
                    print("Reloading data...")
                    // Remove activity indicator and reload table view
                    self.activityIndicator.removeFromSuperview()
                    self.tableView.reloadData()
                }
            }
        }
        
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // dismiss keyboard
        searchBar.endEditing(true)
    }

}

//MARK: TableViewDelegate and DataSource methods
extension UserSearchViewController: UITableViewDelegate, UITableViewDataSource {
  
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath as IndexPath) as! UserTableViewCell
        
        // fill up cell
        cell.login.text = self.users[indexPath.row].login
        cell.avatar.image = UIImage(named: "profile")
        
        let url = self.users[indexPath.row].avatar_url
        
        // Get user avatar from ObjectiveC function
        DispatchQueue.global().async {
            ObjectiveCSearch.image(forUrl: url, completion: {
                (success, image) in
                if (success) {
                    DispatchQueue.main.async {
                        cell.avatar.image = image
                    }
                }
            })
        }
        
        return cell
        
    }
    
}
