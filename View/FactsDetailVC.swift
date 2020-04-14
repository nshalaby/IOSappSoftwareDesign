//
//  FactsDetailVC.swift
//  WasteManagement
//
//  Created by Nadia Shalaby on 2020-04-03.
//  Copyright © 2020 NadiaAigayle. All rights reserved.
//

import UIKit

class FactsDetailVC: UIViewController {
    
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var bgView: UIVisualEffectView!
    
    //variables
    var donation: Donations!
    var organization: Organizations!
    var fact: Facts!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        questionLabel.text = fact.question
        answerLabel.text = fact.answer
        
        if let url = URL(string: fact.img) {
            img.kf.setImage(with: url)
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissDonation))
        tap.numberOfTapsRequired = 1
        bgView.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissDonation() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func gotItClicked(_ sender: Any) {
        
         dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
