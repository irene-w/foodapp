//
//  NewsFeedTableViewCell.swift
//  TasteBuds
//
//  Created by Dewayne Perry on 10/20/17.
//  Copyright © 2017 The University of Texas at Austin. All rights reserved.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    var tasteBud: TasteBud?
    @IBOutlet weak var restaurant: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var worthIt: UIButton!
    @IBOutlet weak var foodPic: UIImageView!
    @IBOutlet weak var profilePic: UIImageView!
    var maxFoodSize = CGSize(width: 225, height: 150)
    var maxProfileSize = CGSize(width: 50, height: 50)
    var foodURL: String?
    var profileURL: String?
    var controller: NewsFeedViewController!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        commonSetup()
        guard let tasteBud = tasteBud else {return}
        restaurant.text = tasteBud.info["Restaurant"]
        name.text = tasteBud.user.info["Name"]
        profileURL = tasteBud.user.info["Profile Pic URL"]
        foodURL = tasteBud.info["FoodPicURL"]
        loadProfilePic(urlString: profileURL!, imageView: profilePic!)
        loadFoodPic(urlString: foodURL!, imageView: foodPic!)
        date.text = TimeAgo.get(tasteBud.info["Date"]!) 
    }
    
    func commonSetup() {
        worthIt.layer.cornerRadius = 5
        worthIt.contentEdgeInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
        foodPic.layer.cornerRadius = 5
        foodPic.layer.masksToBounds = true
        profilePic.layer.cornerRadius = profilePic.frame.width / 2
        profilePic.layer.masksToBounds = true
    }

    private func loadProfilePic(urlString: String, imageView: UIImageView) {
        if let cachedImage = controller.profilePicsCache[urlString] {
            imageView.image = cachedImage
            imageView.frame.size = ImageResize.getNewSize(currentSize: imageView.image?.size, maxSize: maxProfileSize)
            return
        }
        if let url = URL(string: urlString) {
            DispatchQueue.global(qos: .default).async { [weak self] in
                if let imageData = NSData(contentsOf: url) {
                    DispatchQueue.main.async {
                        imageView.image = UIImage(data: imageData as Data)
                        imageView.frame.size = ImageResize.getNewSize(currentSize: imageView.image?.size, maxSize: self?.maxFoodSize)
                        self?.controller.profilePicsCache[urlString] = imageView.image
                        imageView.layer.masksToBounds = true
                    }
                }
            }
        }
    }
    
    private func loadFoodPic(urlString: String, imageView: UIImageView) {
        if let cachedImage = controller.foodPicsCache[urlString] {
            imageView.image = cachedImage
            imageView.frame.size = ImageResize.getNewSize(currentSize: imageView.image?.size, maxSize: maxFoodSize)
            return
        }
        if let url = URL(string: urlString) {
            DispatchQueue.global(qos: .default).async { [weak self] in
                if let imageData = NSData(contentsOf: url) {
                    DispatchQueue.main.async {
                        imageView.image = UIImage(data: imageData as Data)
                        imageView.frame.size = ImageResize.getNewSize(currentSize: imageView.image?.size, maxSize: self?.maxFoodSize)
                        self?.controller.foodPicsCache[urlString] = imageView.image
                        imageView.layer.masksToBounds = true
                    }
                }
            }
        }
    }
}
