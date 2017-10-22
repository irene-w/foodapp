//
//  BackEnd.swift
//  TasteBuds
//
//  Created by Dewayne Perry on 10/21/17.
//  Copyright © 2017 The University of Texas at Austin. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage
import FBSDKLoginKit
import FirebaseAuth

class BackEnd {
    static var ref: DatabaseReference!
    static var user: User!
    static var tasteBuds: [TasteBud] = []
    static var newsFeedDelegate: NewsFeedViewController!
    static func initialize() {
        BackEnd.ref = Database.database().reference()
    }
    
    static func login(fromViewController vc: UIViewController) {
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: vc) { (result, err) in
            if err != nil { print("FB login failed with error: ", err ?? ""); return }
            guard let accessToken = FBSDKAccessToken.current()?.tokenString else {print("Facebook accessToken is nil"); return }
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
            //sign in with firebase
            Auth.auth().signIn(with: credential) { (user, err) in
                if err != nil {print("\ncould not authenticate firebase fb signin",err ?? ""); return }
                print("Firebase user ID is ",Auth.auth().currentUser?.uid ?? "error with firebase login ID in LoadRequest.login()")
                BackEnd.checkIfUserExists()
            }
        }
    }
    
    static func checkIfUserExists() {
        guard let firebaseID = Auth.auth().currentUser?.uid else {print("not logged in to firebase. huge error");return}
        BackEnd.ref.child("Users").child(firebaseID).observeSingleEvent(of: .value, with: { (snapshot) in
            guard snapshot.exists() else {
                print("user does not exist in firebase database", firebaseID)
                BackEnd.createNewUserInFirebase(firebaseID)
                return
            }
            let user = BackEnd.pullUserFromFirebase(snapshot)
            BackEnd.user = user
            //self?.startListening()
            //self?.requestPage?.rideRequestList?.reloadData()
        })
    }
    
    private static func createNewUserInFirebase(_ firebaseID: String) {
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, err) in
            if err != nil {print("failed to print out graph request", err ?? "");return}
            let fbInfo = result as! [String:String]
            let picURL = "http://graph.facebook.com/\(fbInfo["id"]!)/picture?type=large"
            let user = User(url: picURL, name: fbInfo["name"]!)
            user.unique = firebaseID
            BackEnd.ref.child("Users").child(firebaseID).setValue(user.info)
            BackEnd.user = user
            //BackEnd.startListening()
            //BackEnd.requestPage.rideRequestList.reloadData()
        }
    }
    
    private static func pullUserFromFirebase(_ snapshot: DataSnapshot) -> User {
        let userInfo = snapshot.value as! [String: String]
        let user = User(userInfo)
        user.unique = snapshot.key
        return user
    }
    
    static func add(tasteBud: TasteBud) {
        let autoID = BackEnd.ref.child("TasteBuds").childByAutoId().key
        BackEnd.ref.child("TasteBuds/\(autoID)").setValue(tasteBud.info)
        BackEnd.ref.child("TasteBuds by Users/\(tasteBud.user?.unique ?? "err")/TasteBuds/\(autoID)").setValue(tasteBud.info)
        //tasteBud.unique = autoID
    }
    
    static func uploadTasteBud(_ tasteBudInfo: [String:String], _ image: UIImage, delegate: CheckInViewController) {
        guard let uid = Auth.auth().currentUser?.uid else {print("error uploading image, no uid");return}
        let autoID = BackEnd.ref.child("TasteBuds").childByAutoId().key
        let refStore = Storage.storage().reference().child("\(uid)/\("TasteBuds")/\(autoID).jpg")
        let imageData = UIImageJPEGRepresentation(image, 0.1)
        refStore.putData(imageData!, metadata: nil) { (meta, err) in
            if err != nil {print("error uploading image data ", err ?? "");return}
            //print(meta ?? "no meta")
            let url = String(describing: (meta?.downloadURL())!)
            var info = tasteBudInfo
            info["FoodPicURL"] = url
            BackEnd.ref.child("TasteBuds/\(autoID)").setValue(info)
            BackEnd.ref.child("TasteBuds by Users/\(info["User"] ?? "err")/TasteBuds/\(autoID)").setValue(info)
            delegate.goToNewsFeed()
        }
    }
    
    static func listenForTasteBuds() {
        BackEnd.ref.child("TasteBuds").observe(.childAdded) { (snapShot) in
            guard snapShot.exists() else { return }
            let tasteBudID = snapShot.key
            let tasteDetails = snapShot.value as! [String:String]
            var tasteBud = TasteBud(tasteInfo: tasteDetails)
            BackEnd.ref.child("Users/\(tasteDetails["User"] ?? "err")").observeSingleEvent(of: .value, with: { (snapShotUser) in
                let user = pullUserFromFirebase(snapShotUser)
                tasteBud.user = user
                tasteBud.unique = tasteBudID
                tasteBuds.insert(tasteBud, at: 0)
                newsFeedDelegate.feedTableView.reloadData()
            })
        }
    }
    
    private func pullUserFromFirebase(_ snapshot: DataSnapshot) -> User {
        let userInfo = snapshot.value as! [String: String]
        let user = User(userInfo)
        user.unique = snapshot.key
        return user
    }
}
