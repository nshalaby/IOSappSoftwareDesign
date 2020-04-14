//
//  ForgotPasswordVC.swift
//  WasteManagement
//
//  Created by Nadia Shalaby on 2020-04-03.
//  Copyright © 2020 NadiaAigayle. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordVC: UIViewController {
    
    //outlets
    
    @IBOutlet weak var emailText: UITextField!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func cancelClicked(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetClicked(_ sender: Any) {
        
        guard let email = emailText.text, email.isNotEmpty else {
          simpleAlert(title: "Error", msg: "Please enter email.")
            return
            
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) {(error) in
            
            if let error = error {
                debugPrint(error)
                Auth.auth().handleFireAuthError(error: error, vc: self)
                return
                
            }
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
