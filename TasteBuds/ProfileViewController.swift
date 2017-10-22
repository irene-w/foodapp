//
//  ProfileViewController.swift
//  TasteBuds
//
//  Created by Irene Woo on 10/20/17.
//  Copyright © 2017 The University of Texas at Austin. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit
import AlamofireImage

class ProfileViewController: NavBarExtension {
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        loadUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadUI() {
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start(completionHandler: {
            (connection, result, err) -> Void in
            if let fbInfo = result as? [String:String] {
                self.userName.text = fbInfo["name"]!
                let picURL = "http://graph.facebook.com/\(fbInfo["id"]!)/picture?type=large"
                
                if let url = URL(string: (picURL)) {
                    DispatchQueue.global(qos: .default).async {
                        [weak self] in
                        if let imageData = NSData(contentsOf: url) {
                            DispatchQueue.main.async {
                                self?.profilePicture.image = UIImage(data: imageData as Data)
                                self?.profilePicture.layer.cornerRadius = (self?.profilePicture.frame.width)! / 2
                                self?.profilePicture.layer.masksToBounds = true
                            }
                        }
                    }
                } else {
                    print("invalid profile pic url")
                }
            }
        })
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
