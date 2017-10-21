//
//  User.swift
//  TasteBuds
//
//  Created by Irene Woo on 10/21/17.
//  Copyright © 2017 The University of Texas at Austin. All rights reserved.
//

import Foundation
import OHMySQL

class User: NSObject, OHMappingProtocol {
    var name: String?
    var id: NSNumber?
    var location: String?
    var email: String?
    
    func mappingDictionary() -> [AnyHashable : Any]! {
        return ["name": "name",
                "id": "id",
                "location": "location",
                "email": "email"]
    }
    
    func mySQLTable() -> String! {
        return "users"
    }
    
    func primaryKey() -> String! {
        return "id"
    }
}
