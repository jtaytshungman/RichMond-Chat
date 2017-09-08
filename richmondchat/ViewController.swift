//
//  ViewController.swift
//  richmondchat
//
//  Created by Jeremy Tay on 08/09/2017.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit
<<<<<<< HEAD
import Firebase
=======
import FirebaseDatabase
>>>>>>> 39a6ed3b3e7f5ddb71a123656e2dd3201fbc5dec

class ViewController: UIViewController {

    var ref: DatabaseReference!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    func observeFireBase(){
        ref = Database.database().reference() // put it in where you call reference - before you make the call !!
        ref.child(<#T##pathString: String##String#>)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

