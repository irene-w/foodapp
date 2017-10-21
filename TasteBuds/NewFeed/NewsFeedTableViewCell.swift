//
//  NewsFeedTableViewCell.swift
//  TasteBuds
//
//  Created by Dewayne Perry on 10/20/17.
//  Copyright © 2017 The University of Texas at Austin. All rights reserved.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var restaurant: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var worthIt: UIButton!
    @IBOutlet weak var foodPic: UIImageView!
    @IBOutlet weak var profilePic: UIImageView!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        worthIt.layer.cornerRadius = 5
        worthIt.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        foodPic.layer.cornerRadius = 5
        foodPic.layer.masksToBounds = true
        profilePic.layer.cornerRadius = profilePic.frame.width / 2
        profilePic.layer.masksToBounds = true
    }

}
