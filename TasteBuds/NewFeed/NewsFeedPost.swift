//
//  NewsFeedPost.swift
//  TasteBuds
//
//  Created by Dewayne Perry on 10/21/17.
//  Copyright © 2017 The University of Texas at Austin. All rights reserved.
//

import Foundation
import UIKit

struct TasteBud {
    let user: User!
    let restaurant: String!
    let date: Date!
    let time: String!
    let foodPicURL: String!
    let foodPic: UIImage!
    var likes = 0
    var comments = 0
}
