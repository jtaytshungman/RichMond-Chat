//
//  SignUpViewController.swift
//  richmondchat
//
//  Created by Jeremy Tay on 08/09/2017.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SignUpViewController: UIViewController {

    var ref : DatabaseReference!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let confirmPassward = confirmPasswordTextField.text else { return }
        
        if password != confirmPassward {
            print("Error")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: confirmPassward) { (user, error) in
            if let validError = error {
                print(validError.localizedDescription)
            }
            
            if let validUser = user {
                self.ref = Database.database().reference()
                
                let userPost : [String : Any] = ["Email" : email]
                
                self.ref.child("users").child(validUser.uid).setValue(userPost)
                
                self.navigationController?.popViewController(animated: true)
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
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
