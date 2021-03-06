//
//  CheckInViewController.swift
//  TasteBuds
//
//  Created by Irene Woo on 10/21/17.
//  Copyright © 2017 The University of Texas at Austin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

protocol LocationDelegate {
    func LocationObtained(_ latLog: String)
}

class CheckInViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, LocationDelegate {
    
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantNameEntry: UITextField!
    @IBOutlet weak var foodPicture: UIImageView!
    var ref: DatabaseReference!
    var getLocation: GetLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Access the database
        ref = Database.database().reference()
        
        restaurantNameEntry.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        restaurantName.text = textField.text
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        // Dismiss the picker if the user cancelled
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // The image dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image
        foodPicture.image = selectedImage
        
        // Dismiss the picker
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        // Hide the keyboard
        restaurantName.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken
        //imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func goToNewsFeed() {
        let vc = MainTabBarViewController()
        present(vc, animated: true, completion: nil)
/*
    @IBAction func goToNewsFeed(_ sender: Any) {
        // TODO: Get user UID
        // guard let uid = Auth.auth().currentUser?.uid else {
        //    print("Error: no user UID")
        //    return
        //}
        
        // Get Storage reference
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        //TODO: this will overwrite previous version of image. Use uid from above to fix
        let ratingsRef = storageRef.child("Ratings/" + "/food.jpg")
        
        //Upload image
        let imageData = UIImageJPEGRepresentation(foodPicture!.image!, 0.1)
        let uploadTask = ratingsRef.putData(imageData!, metadata:nil) { (metadata, error) in
            guard let metadata = metadata else {
                print("Error while uploading")
                return
            }
            
            //Download URL for image
            let downloadURL = metadata.downloadURL
        }
        
        //Go to news feed
*/
    }

    @IBAction func Go(_ sender: Any) {
        getLocation = GetLocation()
        getLocation.work(delegate: self)
    }
    
    func LocationObtained(_ latLog: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy hh:mm:ss a"
        let date = dateFormatter.string(from: Date())
        let tasteBudInfo = [
            "User"       : BackEnd.user.unique!,
            "Restaurant" : restaurantName.text!,
            "Date"       : date,
            "Location"   : latLog
            ]
        if let foodPic = foodPicture.image {
            BackEnd.uploadTasteBud(tasteBudInfo, foodPic, delegate: self)
        }
    }
}
