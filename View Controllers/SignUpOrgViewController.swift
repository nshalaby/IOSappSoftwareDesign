//
//  SignUpOrgViewController.swift
//  WasteManagement
//
//  Created by Nadia Shalaby on 2020-03-23.
//  Copyright © 2020 NadiaAigayle. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseDatabase


class SignUpOrgViewController: UIViewController {
    

    @IBOutlet weak var orgName: UITextField!
    @IBOutlet weak var OrgPersonName: UITextField!
    @IBOutlet weak var OrgPnumber: UITextField!
    @IBOutlet weak var OrgDescription: UITextField!
    @IBOutlet weak var orgLocation: UITextField!
    @IBOutlet weak var orgWebsite: UITextField!
    @IBOutlet weak var orgEmail: UITextField!
    @IBOutlet weak var orgPassword: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
         setUpElements()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        orgName.resignFirstResponder()
        OrgPersonName.resignFirstResponder()
        OrgPnumber.resignFirstResponder()
        OrgDescription.resignFirstResponder()
        orgLocation.resignFirstResponder()
        orgWebsite.resignFirstResponder()
        orgEmail.resignFirstResponder()
        orgPassword.resignFirstResponder()
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
        errorLabel.alpha = 0
        
        //style the elements
        Utilities.styleTextField(orgName)
        Utilities.styleTextField(OrgPersonName)
        Utilities.styleTextField(OrgPnumber)
        Utilities.styleTextField(OrgDescription)
        Utilities.styleTextField(orgLocation)
        Utilities.styleTextField(orgWebsite)
        Utilities.styleTextField(orgEmail)
        Utilities.styleTextField(orgPassword)
        Utilities.styleFilledButton(signUpButton)
        //description, email, favourite, hours, id, img, location, name, number, timeStamp, website
        
        
    }


    
    @IBAction func backTapped(_ sender: Any) {
       // self.transitionToHome()
        
        transitionBack()
        
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        //description, email, favourite, hours, id, img, location, name, number, timeStamp, website
        guard let email = orgEmail.text, email.isNotEmpty ,
            let password = orgPassword.text, password.isNotEmpty ,
            let name = orgName.text, name.isNotEmpty,
            let location = orgLocation.text, location.isNotEmpty,
            let number = OrgPnumber.text, number.isNotEmpty,
            let website = orgWebsite.text, website.isNotEmpty,
            let hours = OrgPersonName.text, hours.isNotEmpty,
            let orgDescription = OrgDescription.text, orgDescription.isNotEmpty else {
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
            let orgUser = Organizations.init(name: name, id: firUser.uid, img: Constants.AppImages.placeHolder, website: website, location: location, orgDescription: orgDescription, favourite: false, email: email, hours: hours, number: number, timeStamp: Timestamp())

            
            //upload the organization to firebase
            self.createFirestoreUser(organization: orgUser)
            
        }
        
        /*guard let authUser = Auth.auth().currentUser else {
            return
        }
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        authUser.link(with: credential) {(result, error) in
            if let error = error {
                debugPrint(error)
                Auth.auth().handleFireAuthError(error: error, vc: self)
                return
            }
            guard let firUser = result?.user else {return}
            let orgUser = Organizations.init(name: name, id: firUser.uid, img: "i", website: website, location: location, description: orgDescription, favourite: false, email: email, hours: hours, number: number)
            
            //upload to firesore database
            self.createFirestoreUser(organization: orgUser)
           
        }
        // self.transitionToHome()*/
        
        
}


    func createFirestoreUser(organization: Organizations) {
           // Step 1: Create document reference
           let newUserRef = Firestore.firestore().collection("organizations").document(organization.id)
           
           // Step 2: Create model data
           let data = Organizations.modelToData(organization: organization)
        
           // Step 3: Upload to Firestore.
           newUserRef.setData(data) { (error) in
               if let error = error {
                   Auth.auth().handleFireAuthError(error: error, vc: self)
                   debugPrint("Error signing in: \(error.localizedDescription)")
               } else {
               
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
