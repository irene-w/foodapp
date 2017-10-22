//
//  NewsFeedViewController.swift
//  TasteBuds
//
//  Created by Dewayne Perry on 10/20/17.
//  Copyright © 2017 The University of Texas at Austin. All rights reserved.
//

import UIKit

class NewsFeedViewController: NavBarExtension, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var feedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        feedTableView.dataSource = self
        feedTableView.delegate = self
        feedTableView.rowHeight = 236
        feedTableView.tableFooterView = UIView()
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
