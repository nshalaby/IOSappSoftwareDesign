//
//  cartItemCell.swift
//  WasteManagement
//
//  Created by Nadia Shalaby on 2020-04-02.
//  Copyright © 2020 NadiaAigayle. All rights reserved.
//

import UIKit


protocol CartItemDelegate : class {
    func removeItem(donation: Donations)
}

class cartItemCell: UITableViewCell {
//outlets
    @IBOutlet weak var donationImg: RoundedImageView!
    
    @IBOutlet weak var trashCan: UIButton!
    
    @IBOutlet weak var donationLabel: UILabel!
    
        
    private var item: Donations!
    weak var delegate: CartItemDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(donation: Donations, delegate: CartItemDelegate) {
           
        
        self.delegate = delegate
        self.item = donation
        donationLabel.text = "\(donation.name): \(donation.quantity)"
           
           if let url = URL(string: donation.img) {
               donationImg.kf.setImage(with: url)
               
           }
           
           
       }
    
    @IBAction func removeItem(_ sender: Any) {
        
        delegate?.removeItem(donation: item)
    }
    
    
}
