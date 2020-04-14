//
//  LoginViewController.swift
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

class LoginViewController: UIViewController {

    
    @IBOutlet weak var EmailTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var forgotButton: UIButton!
    
    @IBOutlet weak var ErrorLabel: UILabel!
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    
    @IBOutlet weak var backButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
         setUpElements()
    }
 
    
    func setUpElements(){
        
        //Hide the error label
        ErrorLabel.alpha = 0
        
        //style the elements
        Utilities.styleTextField(EmailTextfield)
        
        Utilities.styleTextField(passwordTextfield)
    
        
        Utilities.styleFilledButton(loginButton)
        
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillAppear(_ animated: Bool) {
        //set up video in background
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
     backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
            self.view.addGestureRecognizer(tapGesture)
        }
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
            EmailTextfield.resignFirstResponder()
        passwordTextfield.resignFirstResponder()
        }
    
    @IBAction func backTapped(_ sender: Any) {
        
        transitionBack()
    }
    
    
    @IBAction func forgotTapped(_ sender: Any) {
        let vc = ForgotPasswordVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
        
        
        
    }
    
    
    @IBAction func loginTapped(_ sender: Any) {
        //validate Text Fields
        //Create Cleaned versions of the text field
        let email = EmailTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
       // let userType =
        
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password){
            (result, error) in
            
            if error != nil {
                //couldn't sign in
                self.ErrorLabel.text = error!.localizedDescription
                self.ErrorLabel.alpha = 1
            }
        
            self.transitionToHome()
                
                
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
