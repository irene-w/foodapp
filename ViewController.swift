//
//  ViewController.swift
//  TasteBuds
//
//  Created by Dewayne Perry on 10/20/17.
//  Copyright © 2017 The University of Texas at Austin. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = FBSDKLoginButton()
        loginButton.center = view.center
        loginButton.delegate = self // Remember to set the delegate of the loginButton
        view.addSubview(loginButton)
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        let storyboard = UIStoryboard(name: "NewsFeed", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NewsFeed")
        present(vc, animated: true, completion: nil)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        // Actions for when the user logged out goes here
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let token = FBSDKAccessToken.current() {
            //go to next view controller (news feed)
            let storyboard = UIStoryboard(name: "NewsFeed", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "NewsFeed")
            present(vc, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
