//
//  Constants.swift
//  ChatApp(Group)
//
//  Created by Tan Wei Liang on 11/09/2017.
//  Copyright © 2017 TWL. All rights reserved.
//

import Foundation
import Firebase

struct Constants
{
    struct refs
    {
        static let databaseRoot = Database.database().reference()
        static let databaseChats = databaseRoot.child("chats")
    }
}
