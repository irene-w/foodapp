//
//  CheckInViewController.swift
//  TasteBuds
//
//  Created by Irene Woo on 10/21/17.
//  Copyright © 2017 The University of Texas at Austin. All rights reserved.
//

import UIKit
import OHMySQL

class CheckInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Open connection to database
        let user = OHMySQLUser(userName: "root", password: "deirclam2017", serverName: "localhost", dbName: "tastebuds_db", port: 3306, socket: "/Applications/MAMP/tmp/mysql/mysql.sock")
        let coordinator = OHMySQLStoreCoordinator(user: user!)
        coordinator.encoding = .UTF8MB4
        coordinator.connect()

        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
