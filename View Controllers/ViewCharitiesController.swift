//
//  ViewCharitiesController.swift
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

class ViewCharitiesController: UIViewController, OrganizationCellDelegate {
   
    
    //outlets
    @IBOutlet weak var navBar: UINavigationItem!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBOutlet weak var activityIndicatior: UIActivityIndicatorView!
    
  
    @IBOutlet weak var tableView: UITableView!
    

    //variables
    
    var organizations = [Organizations]()
    var selectedOrganization: Organizations!
    var listener: ListenerRegistration!
    var showFavourites = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    setUpTableView()
    setOrganizationsListener()
        
                
    }
    
   func organizationFavourited(organization: Organizations) {
    
    
        
        UserService.favoriteSelected(organization: organization)
        guard let index = organizations.firstIndex(of: organization) else {return}
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        
        
    }
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
               
        //register the xib
        tableView.register(UINib(nibName: Identifiers.OrganizationCell, bundle: nil), forCellReuseIdentifier: Identifiers.OrganizationCell)
               
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        //set up video in background
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
       }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        listener.remove()
        organizations.removeAll()
        tableView.reloadData()
        
    }
    
    func setOrganizationsListener() {
        
        var ref: Query!
        if showFavourites {
            
            ref = Constants.db.collection("users").document (UserService.user.id).collection("favourites").order(by: "timeStamp", descending: true)
            print("I got here!")
            print(UserService.user.id)
            
            
        } else {
            ref = Constants.db.organizations
        }
        listener = ref.addSnapshotListener({ (snap, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            
            snap?.documentChanges.forEach({ (change) in
            
                let data = change.document.data()
                let organization = Organizations.init(data: data)
                
                switch change.type {
                case .added:
                    self.onDocumentAdded(change: change, organization: organization)
                case .modified:
                    self.onDocumentModified(change: change, organization: organization)
                case .removed:
                    self.onDocumentRemoved(change: change)
                    
                
                }
            })
        })
        
    }
    
    
    
        

    @IBAction func shoppingTapped(_ sender: Any) {
        
        transitionToCart()
        
    }
    
    
    @IBAction func backTapped(_ sender: Any) {
        
        transitionBack()
        
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
    
    
    
    
}
extension ViewCharitiesController: UITableViewDelegate, UITableViewDataSource {
    
    func onDocumentAdded(change: DocumentChange, organization: Organizations) {
        
        let newIndex = Int(change.newIndex)
        organizations.insert(organization, at: newIndex)
        tableView.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .fade)
        
        
    }

    func onDocumentModified(change: DocumentChange, organization: Organizations) {
        if change.oldIndex == change.newIndex {
            //Item changed, but remained in the same position
            let index = Int(change.newIndex)
            organizations[index] = organization
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        } else {
            //item changed and changed position
            let oldIndex = Int(change.oldIndex)
            let newIndex = Int(change.newIndex)
            organizations.remove(at: oldIndex)
            organizations.insert(organization, at: newIndex)
            tableView.moveRow(at: IndexPath(row: oldIndex, section: 0), to: IndexPath(row: newIndex, section: 0))
            
        }
    }

    func onDocumentRemoved(change: DocumentChange) {
        let oldIndex = Int(change.oldIndex)
        organizations.remove(at: oldIndex)
        tableView.deleteRows(at: [IndexPath(row: oldIndex, section: 0)], with: .left)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organizations.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.OrganizationCell, for: indexPath) as? OrgCell {
            
            cell.configureCell(organization: organizations[indexPath.row], delegate: self)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        selectedOrganization = organizations[indexPath.row]
        performSegue(withIdentifier: Segues.toDonations, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Segues.toDonations {
            if let destination = segue.destination as? DonationsViewController {
                
                destination.organization = selectedOrganization
                
                
            }
        } /*else if segue.identifier == Segues.toFavs {
           if let destination = segue.destination as? DonationsViewController {
                
                destination.organization = selectedOrganization
                destination.showFavourites = true
           }
            
        
    }*/
    
    
}





/*func fetchCollection() {
    let collectionRef = Constants.db.collection("organizations")
    
    listener = collectionRef.addSnapshotListener{(snap, error) in
        guard let documents = snap?.documents else{return}
        
        self.organizations.removeAll()
        for documents in documents {
            let data = documents.data()
            let newOrganization = Organizations.init(data: data)
            self.organizations.append(newOrganization)
        }
        
        self.tableView.reloadData()
        
        
    }
    
   // collectionRef.getDocuments{ (snap, error) in
       // guard let documents = snap?.documents else{return}
        //for documents in documents {
         //   let data = documents.data()
           // let newOrganization = Organizations.init(data: data)
            //self.organizations.append(newOrganization)
        //}
        
       // self.tableView.reloadData()
   // }
}

*/
}
