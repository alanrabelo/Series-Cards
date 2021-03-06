//
//  Word.swift
//  Series Cards
//
//  Created by Alan Rabelo Martins on 20/04/17.
//  Copyright © 2017 Alan Rabelo Martins. All rights reserved.
//

import Foundation
import Firebase

class Word : FirebaseModel {
    var word : String!
    var translation : String!
    var translationDescription : String?
    var user : String!
    
    
    init(withWord word : String, andTranslation translation : String, andTranslationDescription translationDescription : String) {
        self.word = word
        self.translation = translation
        self.translationDescription = translationDescription
        self.user = UserDefaults.standard.value(forKey: "id") as! String
    }
    
    required override init() {
        self.user = UserDefaults.standard.value(forKey: "id") as! String
    }
    
    
}



