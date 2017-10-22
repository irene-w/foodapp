//
//  User.swift
//  TasteBuds
//
//  Created by Dewayne Perry on 10/21/17.
//  Copyright © 2017 The University of Texas at Austin. All rights reserved.
//

import Foundation

import Foundation

class User {
    var info: [String: String] = [:]
    var unique: String? {
        didSet {
            info["Unique"] = unique
        }
    }
    var keys = ["Name", "Date Joined", "Profile Pic URL", "Restaurants Visited"]

    init(url: String, name: String) {
        info["Name"] = name
        info["Profile Pic URL"] = url
        info["Restaurants Visited"] = "0"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy hh:mm:ss a"
        let date = dateFormatter.string(from: Date())
        info["Date Joined"] = date
    }
    
    init(_ information: [String: String]) {
        for (key, value) in information {
            info[key] = value
        }
    }

    /*
    func incrementVariable(_ variableToIncrease: String) {
        info[variableToIncrease] = String(describing: Int(info[variableToIncrease]!)! + 1)
        LoadRequests.updateUser(user: self)
        //LoadRequests.gRef.child("Users").child(unique!).child(variableToIncrease).setValue(info[variableToIncrease])
        profileDetails?.updateUI()
    }
    
    func decrementVariable(_ variableToDecrease: String) {
        info[variableToDecrease] = String(describing: Int(info[variableToDecrease]!)! - 1)
        LoadRequests.updateUser(user: self)
        //LoadRequests.gRef.child("Users").child(unique!).child(variableToDecrease).setValue(info[variableToDecrease])
        profileDetails?.updateUI()
    }
 */
}
