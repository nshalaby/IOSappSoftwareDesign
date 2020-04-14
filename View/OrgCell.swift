//
//  OrgCell.swift
//  WasteManagement
//
//  Created by Nadia Shalaby on 2020-04-01.
//  Copyright © 2020 NadiaAigayle. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

protocol OrganizationCellDelegate: class {
    //A protocol delegate pattern delegates actions to another object
    
    func organizationFavourited(organization: Organizations)
    
}

class OrgCell: UITableViewCell {
    
    
    @IBOutlet weak var orgLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    @IBOutlet weak var favButton: UIButton!
    
 
    @IBOutlet weak var orgImg: RoundedImageView!
    
    
    //weak helps with memory leaks
    weak var delegate : OrganizationCellDelegate?
    private var organization: Organizations!
    
   //var organization = Organizations!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    /*override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }*/
    
    func configureCell(organization: Organizations, delegate: OrganizationCellDelegate) {
        
        self.organization = organization
        self.delegate = delegate
        
        
        orgLabel.text = organization.name
        descriptionLabel.text = organization.orgDescription
        if let url = URL(string: organization.img) {
            let placeholder = UIImage(named: Constants.AppImages.placeHolder)
            let options: KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.1))]
            
            orgImg.kf.indicatorType = .activity
            
            orgImg.kf.setImage(with: url, placeholder: placeholder, options: options)
            
        }
        
        if UserService.favorites.contains(organization) {
            //favourite
            favButton.setImage(UIImage(named: Constants.AppImages.filledStar), for: .normal)
        } else {
            favButton.setImage(UIImage(named: Constants.AppImages.emptyStar), for: .normal)
        }
        

    }
    
    
    @IBAction func favClicked(_ sender: Any) {
        
        delegate?.organizationFavourited(organization: organization)
        
    }
    
}
