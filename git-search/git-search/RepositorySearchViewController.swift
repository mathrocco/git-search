//
//  SecondViewController.swift
//  git-search
//
//  Created by Matheus Rocco Ferreira on 05/11/16.
//  Copyright © 2016 Rocco. All rights reserved.
//

import UIKit

class RepositorySearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var activityIndicator = UIActivityIndicatorView()

    var repositories: [Repository] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

//MARK : Searchbar delegate
extension RepositorySearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        print("Searching for repository...")
        
        // get name from searchBar
        let name = searchBar.text
        
        // insert activity activityIndicator
        self.activityIndicator.color = UIColor.gray
        let activityIndicatorFrame = CGRect(x: (self.tableView.frame.width/2)-25, y: (self.tableView.frame.height/2)-25, width: 50, height: 50)
        self.activityIndicator.frame = activityIndicatorFrame
        self.activityIndicator.startAnimating()
        self.tableView.addSubview(self.activityIndicator)
        
        //Search for repository
        Search.findRepositoryWithName(name!) { (success, repositories) in
            if success {
                self.repositories = repositories!
                
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
extension RepositorySearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repositories.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath as IndexPath) as! RepositoryTableViewCell
        
        // fill up cell
        cell.fullName.text = self.repositories[indexPath.row].fullName
        cell.repositoryDescription.text = self.repositories[indexPath.row].repositoryDescription
        cell.language.text = self.repositories[indexPath.row].language
        cell.forks.text = String(describing: self.repositories[indexPath.row].forksCount!)
        cell.stars.text = String(describing: self.repositories[indexPath.row].stars!)
        
        
        return cell
        
    }

}

