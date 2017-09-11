//
//  User.swift
//  ChatApp(Group)
//
//  Created by Tan Wei Liang on 11/09/2017.
//  Copyright © 2017 TWL. All rights reserved.
//

import Foundation

class User {
    var name : String = ""
    var ID: String = ""
    var email : String = ""
    var imageURL : String = ""
    
    init( aName: String, ID: String, anEmail: String, imageURL: String) {
        self.ID = ID
        self.name = aName
        self.email = anEmail
        self.imageURL = imageURL
    }
}
