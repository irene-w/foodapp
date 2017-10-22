//
//  NewsFeedPost.swift
//  TasteBuds
//
//  Created by Dewayne Perry on 10/21/17.
//  Copyright © 2017 The University of Texas at Austin. All rights reserved.
//

import Foundation
import UIKit

struct NewsFeedPost {
    let name: String!
    let restaurant: String!
    let date: Date!
    let time: String!
    let profilePicURL: String!
    let profilePic: UIImage!
    let foodPicURL: String!
    let foodPic: UIImage!
    var likes = 0
    var comments = 0
}
