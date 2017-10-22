//
//  ViewController.swift
//  TasteBuds
//
//  Created by Dewayne Perry on 10/20/17.
//  Copyright © 2017 The University of Texas at Austin. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var login: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // If user already logged in, don't add the login button
        configureButton()

    }
    
    func configureButton() {
        //login.layer.borderWidth = 3
        login.layer.borderColor = UIColor.white.cgColor
        login.layer.cornerRadius = 15
        login.clipsToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        super.viewDidAppear(animated)
        guard let firebaseID = Auth.auth().currentUser?.uid else {return}
        guard let facebookID = FBSDKAccessToken.current()?.tokenString else {return}
        //User is already signed in
        print(firebaseID,facebookID)
        BackEnd.checkIfUserExists()
        if (FBSDKAccessToken.current()) != nil {
            //Go to News Feed
            let vc = MainTabBarViewController()
            present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func loginAction(_ sender: Any) {
        BackEnd.login(fromViewController: self)
    }
    
    
    /*
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Profile")
        present(vc, animated: true, completion: nil)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        // Actions for when the user logged out goes here
    }
*/
}
