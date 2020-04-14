//
//  DonateMoneyController.swift
//  WasteManagement
//
//  Created by Nadia Shalaby on 2020-03-25.
//  Copyright © 2020 NadiaAigayle. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import SwiftUI

class DonateMoneyController: UIViewController {
    
    var websites = [Money]()
    
    
    //var organization: Organizations!
    
    
    var listener: ListenerRegistration!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        setWebsiteListener()

        // Do any additional setup after loading the view.
    }
    
//Outlet
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        //set up video in background
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
     backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    @IBAction func backButton(_ sender: Any) {
        transitionBack()
        
    }
    
    
    @IBAction func cartClicked(_ sender: Any) {
        
        transitionToCart()
    }
    
    func transitionToCart(){
        
        let cartViewController =
            storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.CartPage) as?
                CheckoutVC
        
        view.window?.rootViewController = cartViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    func transitionBack(){
        
        let homeViewController =
            storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as?
                HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    func setWebsiteListener() {
           
          // var ref: Query!
           //let orgAccess = organization.id
          // print(orgAccess)
           
           listener = Constants.db.collection("money").addSnapshotListener({ (snap, error) in
               if let error = error {
                   //whereField("organization", isEqualTo: organization.id).order(by: "timeStamp", descending: true)
                   //print(self.listener!)
                   debugPrint(error.localizedDescription)
                   
                   
                   
               }
               
               snap?.documentChanges.forEach({ (change) in
                   print(self.listener!)
               
                   let data = change.document.data()
                   let website = Money.init(data: data)
                   
                   switch change.type {
                   case .added:
                       self.onDocumentAdded(change: change, website: website)
                   case .modified:
                       self.onDocumentModified(change: change, website: website)
                   case .removed:
                       self.onDocumentRemoved(change: change)
                       
                   
                   }
               })
           })
           
       }
       
       
       func setUpTableView() {
           
           tableView.delegate = self
           tableView.dataSource = self
                  
           //register the xib
           tableView.register(UINib(nibName: Identifiers.MoneyCell, bundle: nil), forCellReuseIdentifier: Identifiers.MoneyCell)
                  
       }

}

extension DonateMoneyController: UITableViewDelegate, UITableViewDataSource {
    
    
    func onDocumentAdded(change: DocumentChange, website: Money) {
        
        let newIndex = Int(change.newIndex)
        websites.insert(website, at: newIndex)
        tableView.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .fade)
        
        
    }

    func onDocumentModified(change: DocumentChange, website: Money) {
        if change.oldIndex == change.newIndex {
            //Item changed, but remained in the same position
            let index = Int(change.newIndex)
            websites[index] = website
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        } else {
            //item changed and changed position
            let oldIndex = Int(change.oldIndex)
            let newIndex = Int(change.newIndex)
            websites.remove(at: oldIndex)
            websites.insert(website, at: newIndex)
            tableView.moveRow(at: IndexPath(row: oldIndex, section: 0), to: IndexPath(row: newIndex, section: 0))
            
        }
    }

    func onDocumentRemoved(change: DocumentChange) {
        let oldIndex = Int(change.oldIndex)
        websites.remove(at: oldIndex)
        tableView.deleteRows(at: [IndexPath(row: oldIndex, section: 0)], with: .left)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.MoneyCell, for: indexPath ) as? MoneyCell {
            
        cell.configureCell(website: websites[indexPath.row])
            return cell
            
            
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

 
