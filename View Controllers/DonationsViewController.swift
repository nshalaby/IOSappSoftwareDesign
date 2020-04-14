//
//  DonationsViewController.swift
//  WasteManagement
//
//  Created by Nadia Shalaby on 2020-04-01.
//  Copyright © 2020 NadiaAigayle. All rights reserved.
//

import UIKit
import FirebaseFirestore

class DonationsViewController: UIViewController, donationCellDelegate {
    
    
    
    //Outlets
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    
    //variables
    
    var donations = [Donations]()
    var organization: Organizations!
    
    var listener: ListenerRegistration!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: Identifiers.donationCell, bundle: nil), forCellReuseIdentifier: Identifiers.donationCell)
        
        setDonationsListener()
        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        //set up video in background
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
     backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    
    
    func setDonationsListener() {
        
        
        listener = Constants.db.collection("donations").whereField("organization", isEqualTo: organization.id).addSnapshotListener({ (snap, error) in
            if let error = error {
               
                debugPrint(error.localizedDescription)
            
            }
            
            snap?.documentChanges.forEach({ (change) in
                print(self.listener!)
            
                let data = change.document.data()
                let donation = Donations.init(data: data)
                
                switch change.type {
                case .added:
                    self.onDocumentAdded(change: change, donation: donation)
                case .modified:
                    self.onDocumentModified(change: change, donation: donation)
                case .removed:
                    self.onDocumentRemoved(change: change)
                    
                
                }
            })
        })
        
    }
    
    @IBAction func backTapped(_ sender: Any) {
        
        //back to chaities page
        
        transitionBack()
        
    }
    
    
    @IBAction func favouritesTapped(_ sender: Any) {
    }
    
    @IBAction func shoppingTapped(_ sender: Any) {
        
        transitionToCart()
    }
    
    
    func transitionBack(){
        
        let charitiesViewController =
            storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.orgPage) as?
                ViewCharitiesController
        
        view.window?.rootViewController = charitiesViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    func transitionToCart(){
        
        let cartViewController =
            storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.CartPage) as?
                CheckoutVC
        
        view.window?.rootViewController = cartViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    func donationAddToCart(donation: Donations) {
        //conform to protcol
        Cart.addItemToCart(item: donation)
    }
    
}

extension DonationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func onDocumentAdded(change: DocumentChange, donation: Donations) {
        
        let newIndex = Int(change.newIndex)
        donations.insert(donation, at: newIndex)
        tableView.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .fade)
        
        
    }

    func onDocumentModified(change: DocumentChange, donation: Donations) {
        if change.oldIndex == change.newIndex {
            //Item changed, but remained in the same position
            let index = Int(change.newIndex)
            donations[index] = donation
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        } else {
            //item changed and changed position
            let oldIndex = Int(change.oldIndex)
            let newIndex = Int(change.newIndex)
            donations.remove(at: oldIndex)
            donations.insert(donation, at: newIndex)
            tableView.moveRow(at: IndexPath(row: oldIndex, section: 0), to: IndexPath(row: newIndex, section: 0))
            
        }
    }

    func onDocumentRemoved(change: DocumentChange) {
        let oldIndex = Int(change.oldIndex)
        donations.remove(at: oldIndex)
        tableView.deleteRows(at: [IndexPath(row: oldIndex, section: 0)], with: .left)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return donations.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.donationCell, for: indexPath ) as? DonationCell {
            
            cell.configureCell(donation: donations[indexPath.row], delegate: self)
            return cell
            
            
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DonationDetailVC()
        let selectedDonation = donations[indexPath.row]
        vc.donation = selectedDonation
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
