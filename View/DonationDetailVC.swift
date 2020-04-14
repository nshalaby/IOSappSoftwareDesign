//
//  DonationDetailVC.swift
//  WasteManagement
//
//  Created by Nadia Shalaby on 2020-04-03.
//  Copyright © 2020 NadiaAigayle. All rights reserved.
//

import UIKit

class DonationDetailVC: UIViewController {
    
    
    //Outlets
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var donationLabelTitle: UILabel!
    @IBOutlet weak var organizaionLabel: UILabel!
    
    @IBOutlet weak var donationCategoryLabel: UILabel!
    
    @IBOutlet weak var vgView: UIVisualEffectView!
    
    //variables
    var donation: Donations!
    var organization: Organizations!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // let orgName = Constants.db.collection("organizations").whereField("id", isEqualTo: donation.organization)
        donationLabelTitle.text = donation.name
        organizaionLabel.text = donation.type
        donationCategoryLabel.text = donation.orgName
        
        if let url = URL(string: donation.img) {
            img.kf.setImage(with: url)
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissDonation))
        tap.numberOfTapsRequired = 1
        vgView.addGestureRecognizer(tap)
        
    }
    @objc func dismissDonation() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func addToCart(_ sender: Any) {
        
        Cart.addItemToCart(item: donation)
        
        //Add product to cart
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func exitClicked(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    

}
