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
    var foodPicsCache: [String:UIImage] = [:]
    var profilePicsCache: [String:UIImage] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        feedTableView.dataSource = self
        feedTableView.delegate = self
        feedTableView.rowHeight = 236
        feedTableView.tableFooterView = UIView()
        BackEnd.newsFeedDelegate = self
        BackEnd.listenForTasteBuds()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BackEnd.tasteBuds.count + 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsFeedPost", for: indexPath) as! NewsFeedTableViewCell
        cell.controller = self
        if indexPath.row < BackEnd.tasteBuds.count {
            cell.tasteBud = BackEnd.tasteBuds[indexPath.row]
        }
        return cell
    }
    
}
