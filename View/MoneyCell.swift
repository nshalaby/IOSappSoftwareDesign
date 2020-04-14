//
//  MoneyCell.swift
//  WasteManagement
//
//  Created by Nadia Shalaby on 2020-04-02.
//  Copyright © 2020 NadiaAigayle. All rights reserved.
//

import UIKit
import SafariServices

class MoneyCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       // wesiteButton.addTarget(self, action: Selector(("websiteClicked")), for: .touchUpInside)
        
    }
    
    
    @IBOutlet weak var orgImg: UIImageView!
    
    
    @IBOutlet weak var wesiteButton: UIButton!
    
    
    @IBAction func websiteClicked(_ sender: Any) {
        
        
        if let appURL = URL(string: "https://www.canadahelps.org/en/charities/bridges-to-hope-inc/#donate-now-pane" ){
            
            UIApplication.shared.open(appURL) { success in
                
                if success {
                    print ("the URL was delivered successfully.")
                } else {
                    print("the URL failed to open")
                }
            }
        }
        
        //UIApplication.shared.open(URL(string:"https://www.canadahelps.org/en/charities/bridges-to-hope-inc/#donate-now-pane")!)
        
        
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureCell(website: Money) {
        
        wesiteButton.setTitle(website.website, for: .normal)
        
        
        if let url = URL(string: website.img) {
            orgImg.kf.setImage(with: url)
            
        }
        
        
    }
   
    
}
