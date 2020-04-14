//
//  HomeViewController.swift
//  WasteManagement
//
//  Created by Nadia Shalaby on 2020-03-23.
//  Copyright © 2020 NadiaAigayle. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class HomeViewController: UIViewController {
    
    
   
    
    

    @IBOutlet weak var navItem: UINavigationBar!
    @IBOutlet weak var shoppingButton: UIBarButtonItem!
    @IBOutlet weak var favouriteButton: UIBarButtonItem!
    @IBOutlet weak var loginButton: UIBarButtonItem!
    @IBOutlet weak var viewCharitiesButton: UIButton!
    @IBOutlet weak var donateMoneyButton: UIButton!
    @IBOutlet weak var factsButton: UIButton!
    
    var showFavourites = false
    var selectedOrganization: Organizations!
    var organizations = [Organizations]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupNavigationBar()

        // Do any additional setup after loading the view.
        setUpElements()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //set up video in background
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    
    func setupNavigationBar() {
           guard let font = UIFont(name: "futura", size: 26) else { return }
           navigationController?.navigationBar.titleTextAttributes = [
               NSAttributedString.Key.foregroundColor: UIColor.white,
               NSAttributedString.Key.font: font]
       }
    
    
   /* func setupInitialAnonymousUser() {
           if Auth.auth().currentUser == nil {
               Auth.auth().signInAnonymously { (result, error) in
                   if let error = error {
                       Auth.auth().handleFireAuthError(error: error, vc: self)
                       debugPrint(error)
                   }
               }
           }
       }*/
       

  
    override func viewDidAppear(_ animated: Bool) {
       
        if (Auth.auth().currentUser != nil) {
            
            loginButton.title = "Logout"
            if UserService.userListener == nil {
                UserService.getCurrentUser()
            }
            
        } else {
                loginButton.title = "Login"
            }
    }
    
    
    func setUpElements() {
        //style the buttons
        Utilities.styleFilledButton(viewCharitiesButton)
        
        Utilities.styleFilledButton(donateMoneyButton)
        Utilities.styleHollowButton(factsButton)
    }
    
    fileprivate func presentLoginController() {
        
        let loginViewController =
            storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.loginPage) as?
                LoginViewController
        
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
        
    }

  
    
   
    
    @IBAction func loginTapped(_ sender: Any) {
      
            guard let user = Auth.auth().currentUser else {return}
            if user.isAnonymous {
                presentLoginController()
            } else {
                do {
                    try Auth.auth().signOut()
                    UserService.logoutUser()
                    Auth.auth().signInAnonymously {(result, error) in
                        if let error = error {
                            Auth.auth().handleFireAuthError(error: error, vc: self)
                            debugPrint(error)
                            
                        }
                        self.presentLoginController()
                        
                    }
                } catch {
                    Auth.auth().handleFireAuthError(error: error, vc: self)
                    debugPrint(error)
                }
            }
        
    }
    
    
    @IBAction func charitesButtonTapped(_ sender: Any) {
        
        //transition to the charities page
        transitionToCharities()
        
        
    }
  
    @IBAction func donateMoneyTapped(_ sender: Any) {
        
        //transition to the donate money page
        transitionToMoney()
    }
    
    @IBAction func factsTapped(_ sender: Any) {
        
        //transition to the facts page
        transitionToFacts()
    }
    
    
    @IBAction func favTapped(_ sender: Any) {
        
        transitionToFavs()
        
    }
    
    @IBAction func shoppingTapped(_ sender: Any) {
        
        
    }
    
    
    func transitionBack(){
        
        let mainViewController =
            storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.Main) as?
                ViewController
        
        view.window?.rootViewController = mainViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    func transitionToCharities(){
        
        let orgViewController =
            storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.orgPage) as? ViewCharitiesController
        
        view.window?.rootViewController = orgViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    
    func transitionToFavs(){
        
        let orgViewController =
            storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.orgPage) as? ViewCharitiesController
        
        orgViewController!.showFavourites = true
        view.window?.rootViewController = orgViewController
        view.window?.makeKeyAndVisible()
        
       
        
        
    }
    
    func transitionToMoney(){
        
        let moneyViewController =
            storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.moneyPage) as? DonateMoneyController
        
        view.window?.rootViewController = moneyViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    func transitionToFacts(){
        
        let factsViewController =
            storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.factsPage) as? FactsController
        
        view.window?.rootViewController = factsViewController
        view.window?.makeKeyAndVisible()
        
    }
    

}
