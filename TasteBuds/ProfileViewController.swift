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

class ProfileViewController: UIViewController {
    @IBOutlet weak var profilePicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getPicture()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getPicture()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPicture() {
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start(completionHandler: {
            (connection, result, err) -> Void in
            if let fbInfo = result as? [String:String] {
                let picURL = "http://graph.facebook.com/\(fbInfo["id"]!)/picture?type=large"
                
                if let url = URL(string: (picURL)) {
                    DispatchQueue.global(qos: .default).async {
                        [weak self] in
                        if let imageData = NSData(contentsOf: url) {
                            DispatchQueue.main.async {
                                self?.profilePicture.image = UIImage(data: imageData as Data)
                            }
                        }
                    }
                } else {
                    print("invalid profile pic url")
                }
                
                /*let downloader = ImageDownloader()
                let urlRequest = URLRequest(url: URL(string: picURL)!)
                
                downloader.download(urlRequest) { response in
                    print(response.request)
                    print(response.response)
                    debugPrint(response.result)
                    
                    if let image = response.result.value {
                        self.profilePicture.image = image
                    }
                }*/

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
