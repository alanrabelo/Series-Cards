//
//  FirebaseModel.swift
//  Series Cards
//
//  Created by Alan Rabelo Martins on 20/04/17.
//  Copyright © 2017 Alan Rabelo Martins. All rights reserved.
//

import Foundation
import Firebase

class FirebaseModel: NSObject {
    required override init() {
        
    }
}

extension FirebaseModel {
    func propertyNames() -> [String] {
        return Mirror(reflecting: self).children.flatMap { $0.label }
    }
    
    
    func toJSON() -> [String : Any] {
        var objectJSON = [String:Any]()
        
        for property in self.propertyNames() {
            objectJSON[property] = self.value(forKey: property)
        }
        
        return objectJSON
    }
    
    func save() {
        let reference = FIRDatabase.database().reference().child(self.className).childByAutoId()
        reference.setValue(self.toJSON())
        
    }
    
    static func all(withCompletion completion : @escaping ([AnyObject])->Void) {
        let reference = FIRDatabase.database().reference().child(self.className)
        
        reference.observe(.value, with: { (snapshot) in
            if let values = snapshot.value as? [String:Any] {
                print(values)
                var words : [AnyObject] = []
                for value in values.keys {
                    let object = self.init()
                    let word = values[value]! as! [String:Any]
                    for property in object.propertyNames() {
                        object.setValue(word[property], forKey: property)
                    }
                    words.append(object)
                }
                completion(words)
            }
        })
    }
}

extension FirebaseModel {
    

    static var className: String {
        return String(describing: self)
    }
    var className: String {
        return String(describing: type(of: self))
    }
}
