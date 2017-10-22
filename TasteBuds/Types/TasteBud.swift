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
    var user: User!
    var info: [String: String] = [:]
    var unique: String!
    init (tasteInfo: [String:String]) {
        //user =
        unique = ""
        info = tasteInfo
    }
}
