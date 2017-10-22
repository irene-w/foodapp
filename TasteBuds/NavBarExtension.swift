//
//  NavBar.swift
//  TasteBuds
//
//  Created by Dewayne Perry on 10/21/17.
//  Copyright © 2017 The University of Texas at Austin. All rights reserved.
//

import Foundation
import UIKit

class NavBarExtension: UIViewController {
    
}

extension NavBarExtension {
    func configureNavBar() {
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(red:0.99, green:0.34, blue:0.22, alpha:1.0)
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "title"))
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Check In", style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "checkIn"), style: .plain, target: self, action: #selector(checkIn))
        
        //navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    @objc func checkIn() {
        let storyboard = UIStoryboard(name: "CheckIn", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CheckIn")
        //present(vc, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}
