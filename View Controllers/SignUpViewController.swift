//
//  SignUpViewController.swift
//  WasteManagement
//
//  Created by Nadia Shalaby on 2020-03-23.
//  Copyright © 2020 NadiaAigayle. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import SwiftUI
import FirebaseDatabase


class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var PersonalFirstName: UITextField!
    @IBOutlet weak var PersonalLastName: UITextField!
    @IBOutlet weak var PersonalEmail: UITextField!
    @IBOutlet weak var PersonalPassword: UITextField!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var ErrorLabel: UILabel!
    @IBOutlet weak var navBackButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        

        // Do any additional setup after loading the view.
        
        setUpElements()
        //setUpNavigationBarItems()
         let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
            self.view.addGestureRecognizer(tapGesture)
        }
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
            PersonalFirstName.resignFirstResponder()
        PersonalLastName.resignFirstResponder()
        PersonalEmail.resignFirstResponder()
        PersonalPassword.resignFirstResponder()
        }
    
    override func viewWillAppear(_ animated: Bool) {
        //set up video in background
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
     backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    func setUpElements(){
        
        //Hide the error label
        ErrorLabel.alpha = 0
        
        //style the elements
        Utilities.styleTextField(PersonalFirstName)
        Utilities.styleTextField(PersonalLastName)
        Utilities.styleTextField(PersonalEmail)
        Utilities.styleTextField(PersonalPassword)
        Utilities.styleFilledButton(SignUpButton)
        
    }
    

    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        //back to previous screen
        
        transitionBack()
    }
    
    @IBAction func SignUpTapped(_ sender: Any) {
        
        guard let email = PersonalEmail.text, email.isNotEmpty ,
            let firstName = PersonalFirstName.text, firstName.isNotEmpty,
            let lastName = PersonalLastName.text, lastName.isNotEmpty,
            let password = PersonalPassword.text, password.isNotEmpty else {
                
                simpleAlert(title: "Error", msg: "Please fill out all fields")
                return
        }
            
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                debugPrint(error)
                Auth.auth().handleFireAuthError(error: error, vc: self)
                return
            }
            
            guard let firUser = result?.user else {return}
            let personUser = User.init(id: firUser.uid, email: email, firstName: firstName, lastName: lastName)
            
            //upload to firestore
            self.createFirestoreUser(user: personUser)
        }
        
        //this is for the guest option to be implemented later
        
        /*
            guard let authUser = Auth.auth().currentUser else {
                return
            }
            
            let credential = EmailAuthProvider.credential(withEmail: email, link: password)
            
        authUser.link(with: credential) { (result, error) in
            
            if let error = error {
                debugPrint(error)
                Auth.auth().handleFireAuthError(error: error, vc: self)
                return
                
            }
            
            guard let firUser = result?.user else {return}
            let personUser = User.init(uid: firUser.uid, email: email, firstName: firstName, lastName: lastName)
            //upload to fireStore
            self.createFirestoreUser(user: personUser)
           
        }
 */
    }
            
            
                    
                    
                  
        
      
    
    func createFirestoreUser(user: User) {
           // Step 1: Create document reference
           let newUserRef = Firestore.firestore().collection("users").document(user.id)
           
           // Step 2: Create model data
           let data = User.modelToData(user: user)
           
           // Step 3: Upload to Firestore.
           newUserRef.setData(data) { (error) in
               if let error = error {
                   Auth.auth().handleFireAuthError(error: error, vc: self)
                   debugPrint("Error signing in: \(error.localizedDescription)")
               } else {
                  // self.dismiss(animated: true, completion: nil)
                self.transitionToHome()
               }
              
           }
       }
    func transitionToHome(){
        
        let homeViewController =
            storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as?
                HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
    func transitionBack(){
        
        let mainViewController =
            storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.Main) as?
                ViewController
        
        view.window?.rootViewController = mainViewController
        view.window?.makeKeyAndVisible()
        
    }
}

