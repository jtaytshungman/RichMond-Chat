//
//  User.swift
//  richmondchat
//
//  Created by Tan Wei Liang on 08/09/2017.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import Foundation


class User {
    var name : String = ""
    var email : String = ""
    var imageUrl : String = ""
    
    init(name : String, email : String, imageUrl : String){
        self.name = name
        self.email = email
        self.imageUrl = imageUrl
    }
}
