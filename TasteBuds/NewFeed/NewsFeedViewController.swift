//
//  NewsFeedViewController.swift
//  TasteBuds
//
//  Created by Dewayne Perry on 10/20/17.
//  Copyright © 2017 The University of Texas at Austin. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var feedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "NewsFeed"
        feedTableView.dataSource = self
        feedTableView.delegate = self
        feedTableView.rowHeight = 236
        
        //tabBarItem.image = #imageLiteral(resourceName: "activity")
        //tabBarItem.title = ""
        
        //tabBarController?.tabBar.items?.insert(UITabBarItem(title: "", image: #imageLiteral(resourceName: "pin"), tag: 0), at: 0)
        //tabBarController?.tabBar.items?.append(UITabBarItem(title: "", image: #imageLiteral(resourceName: "profile"), tag: 0))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsFeedPost", for: indexPath) as! NewsFeedTableViewCell
        
        return cell
    }
    
}
