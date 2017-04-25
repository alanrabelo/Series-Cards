//
//  User.swift
//  Series Cards
//
//  Created by Alan Rabelo Martins on 20/04/17.
//  Copyright © 2017 Alan Rabelo Martins. All rights reserved.
//

import Foundation
import CloudKit
import Firebase

class User : FirebaseModel {
    var name : String!
    
    init(withName name : String) {
        self.name = name
    }
    
    required override init() {
        
    }
    
    static func verifyiCloud() {
        if UserDefaults.standard.value(forKey: "id") == nil {
            CKContainer.default().fetchUserRecordID { (id, error) in
                
                var userId : String
                
                if error != nil {
                    print("Error fetching user icloud - \(error!.localizedDescription)")
                    let idFirebase = FIRDatabase.database().reference().childByAutoId().description().components(separatedBy: ".").last!
                    UserDefaults.standard.set(id, forKey: "id")
                    userId = idFirebase
                } else {
                    UserDefaults.standard.set(id!.recordName, forKey: "id")
                    userId = id!.recordName
                }
                
                let user = User(withName: "Alan Rabeloo")
                
                user.save(withId : userId)
            }
            
        }
    }
    
    
}
