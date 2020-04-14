//
//  DonationCell.swift
//  WasteManagement
//
//  Created by Nadia Shalaby on 2020-04-01.
//  Copyright © 2020 NadiaAigayle. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

protocol donationCellDelegate: class {
    func donationAddToCart(donation: Donations)
}
class DonationCell: UITableViewCell {
//Outlets
    
    @IBOutlet weak var donationImg: RoundedImageView!
    
    @IBOutlet weak var donationCategory: UILabel!
    
    @IBOutlet weak var categoryType: UILabel!
    
    @IBOutlet weak var addToCart: RoundedButton!
    
    @IBOutlet weak var favButton: UIButton!
    
    weak var delegate: donationCellDelegate?
    private var donation: Donations!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //addToCart.setTitle("Add to Donation Cart", for: .normal)
    }
    

    func configureCell(donation: Donations, delegate: donationCellDelegate) {
        self.donation = donation
        self.delegate = delegate
        
        donationCategory.text = donation.name
        categoryType.text = donation.type
        
        if let url = URL(string: donation.img) {
            donationImg.kf.setImage(with: url)
            
        }
        
        
    }
    
    @IBAction func addToCart(_ sender: Any) {
        
        delegate?.donationAddToCart(donation: donation)
    }
    
   
    
}
