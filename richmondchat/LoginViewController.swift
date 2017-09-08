//
//  LoginViewController.swift
//  richmondchat
//
//  Created by Jeremy Tay on 08/09/2017.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth


class LoginViewController: UIViewController {

    var ref : DatabaseReference!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passworddTextField: UITextField!
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        guard let email = emailTextField.text else {
            return
        }
        
        guard let password = passworddTextField.text else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let validError = error {
                self.alertPrompt(title: "Login Error", message: "Wrong Email or Password")
            }
            
            if let validUser = user {
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                guard let vc = storyboard.instantiateViewController(withIdentifier: "") as? ViewController else { return }
                self.present(vc, animated: true, completion: nil)
            }
            
        }
        
    }
    
    func alertPrompt (title : String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
