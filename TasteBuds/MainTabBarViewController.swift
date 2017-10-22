//
//  NewsFeedTabBarViewController.swift
//  TasteBuds
//
//  Created by Dewayne Perry on 10/21/17.
//  Copyright © 2017 The University of Texas at Austin. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isTranslucent = false
        
        self.navigationController?.view.backgroundColor = UIColor.white
        self.tabBar.barTintColor = UIColor.white
        self.tabBar.backgroundColor = UIColor.white
        
        let mapsVC = UIStoryboard(name: "Maps", bundle: nil).instantiateViewController(withIdentifier: "Maps")
        mapsVC.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "pin"), tag: 0)
        mapsVC.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        let newsFeedVC = UIStoryboard(name: "NewsFeed", bundle: nil).instantiateViewController(withIdentifier: "NewsFeed")
        newsFeedVC.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "activity"), tag: 1)
        newsFeedVC.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        let profileVC = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "Profile")
        profileVC.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "profile"), tag: 2)
        profileVC.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        viewControllers = [mapsVC, newsFeedVC, profileVC]
        selectedIndex = 1
    }

}
