//
//  ProfilePageViewController.swift
//  richmondchat
//
//  Created by Tan Wei Liang on 08/09/2017.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class ProfilePageViewController: UIViewController {
    
    var selectedUser : User?
    var ref : DatabaseReference!
    var imageUrl : String = ""
    
    
    
    

    @IBOutlet weak var editButtonTapped: UIButton!{
        didSet {
            editButtonTapped.addTarget(self, action: #selector(editBtnTapped), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField?{
        didSet {
            usernameTextField?.isUserInteractionEnabled = false //keyboard will not come out when the user tappes on the keyboard
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let user = selectedUser?.name,
            let urlImage = selectedUser?.imageURL else {
                return
            
        }
        
        
        
        
        usernameTextField?.text = user
        loadImage(urlString: urlImage)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(signOutUser))


        // Do any additional setup after loading the view.
    }
    
    func signOutUser() {
        do  {
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil) //
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
    func loadImage(urlString : String) {
        //1.url
        //2.session
        //3.task
        //4.start
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    self.profilePicImageView.image = UIImage(data: data)
                }
            }
        }
        task.resume()
    }
    
    func updateProfilePicEnable() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func editBtnTapped() {
        if editButtonTapped.titleLabel?.text == "Edit" {
            usernameTextField?.isUserInteractionEnabled = true
            updateProfilePicEnable() //Enable user to change profile pic
            editButtonTapped.setTitle("Done", for: .normal)
        } else {
            
            usernameTextField?.isUserInteractionEnabled = false
            
            ref = Database.database().reference()
            
            //get the id of the specific student
            guard let name = usernameTextField?.text
               else {return}
            
            let post : [String:Any] = ["name": name, "imageUrl": imageUrl]
            
            //dig path to the student
            //ref.child("students").child(id).updateChildValues(post)
            
            //
            
            editButtonTapped.setTitle("Edit", for: .normal)
        }
        
        //navigationController?.popViewController(animated: true)
    }
    
    func uploadImageToStorage(_ image: UIImage) {
        let ref = Storage.storage().reference()
        
        let timeStamp = Date().timeIntervalSince1970
        
        //compress image so that the image isn't too big
        guard let imageData = UIImageJPEGRepresentation(image, 0.5) else {return}
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        //metadata gives us the url to retrieve the data on the cloud
        
        ref.child("\(timeStamp).jpeg").putData(imageData, metadata: metaData) { (meta, error) in
            if let validError = error {
                print(validError.localizedDescription)
            }
            
            if let downloadPath = meta?.downloadURL()?.absoluteString {
                self.imageUrl = downloadPath
                self.profilePicImageView.image = image
            }
        }
    }


   
}

extension ProfilePageViewController : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        defer {
        
        dismiss(animated: true,completion:  nil)
        }
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {return}
        
        uploadImageToStorage(image)
    }
}
