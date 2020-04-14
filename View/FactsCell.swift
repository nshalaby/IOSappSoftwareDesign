//
//  FactsCell.swift
//  WasteManagement
//
//  Created by Nadia Shalaby on 2020-04-02.
//  Copyright © 2020 NadiaAigayle. All rights reserved.
//

import UIKit

class FactsCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var img: UIImageView!
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func heartTapped(_ sender: Any) {
    
        
    }
    
    func configureCell(fact: Facts) {
           
           questionLabel.text = fact.question
           answerLabel.text = fact.answer
           
           if let url = URL(string: fact.img) {
               img.kf.setImage(with: url)
               
           }
           
           
       }
       
    
}
