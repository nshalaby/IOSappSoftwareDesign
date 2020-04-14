//
//  CheckoutVC.swift
//  WasteManagement
//
//  Created by Nadia Shalaby on 2020-04-02.
//  Copyright © 2020 NadiaAigayle. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import SwiftUI


class CheckoutVC: UIViewController, CartItemDelegate {
   
    

    //outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var activityIndic: UIActivityIndicatorView!
    
    //variables
    var donations = [Donations]()
    var organization: Organizations!
    var listener: ListenerRegistration!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpLabels()

       }
       
    @IBAction func confirmTapped(_ sender: Any) {
        
        simpleAlert(title: "Thank You for your donation", msg: "Please drop off items by the date indicated")
        
    }
    @IBAction func backClicked(_ sender: Any) {
        transitionBack()
    }
    func transitionBack(){
        
        let homeViewController =
            storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as?
                HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    func setUpLabels(){
        
        var dayComponent    = DateComponents()
        dayComponent.day    = 14
        let theCalendar     = Calendar.current
        let nextDate        = theCalendar.date(byAdding: dayComponent, to: Date())!
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        let dateTime = formatter.string(from: nextDate)
        dateLabel.text = dateTime
        numberLabel.text = String(Cart.totalItems)
        
    }
   
    func removeItem(donation: Donations) {
        Cart.removeItemFromCart(item: donation)
        tableView.reloadData()
        setUpLabels()
       }
    
    func setUpTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
               
        //register the xib
        tableView.register(UINib(nibName: Identifiers.CartCell, bundle: nil), forCellReuseIdentifier: Identifiers.CartCell)
               
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //set up video in background
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
     backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
}

extension CheckoutVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cart.cartItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.CartCell, for: indexPath ) as? cartItemCell {
            let myDonation = Cart.cartItems[indexPath.row]
            cell.configureCell(donation: myDonation, delegate: self)
            return cell
            
            
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

