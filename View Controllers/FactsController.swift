//
//  FactsController.swift
//  WasteManagement
//
//  Created by Nadia Shalaby on 2020-03-25.
//  Copyright © 2020 NadiaAigayle. All rights reserved.
//

import UIKit
import Firebase


class FactsController: UIViewController {
    
    //outlet
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //variables
    
    var facts = [Facts]()
    
    
    //var organization: Organizations!
    
    
    var listener: ListenerRegistration!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setUpTableView()
        setFactsListener()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func cartClicked(_ sender: Any) {
        
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
        
    
    override func viewWillAppear(_ animated: Bool) {
        //set up video in background
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
     backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    
    func transitionBack(){
        
        let homeViewController =
            storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as?
                HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
  
    
    func setFactsListener() {
        
       // var ref: Query!
        //let orgAccess = organization.id
       // print(orgAccess)
        
        listener = Constants.db.collection("facts").addSnapshotListener({ (snap, error) in
            if let error = error {
                //whereField("organization", isEqualTo: organization.id).order(by: "timeStamp", descending: true)
                //print(self.listener!)
                debugPrint(error.localizedDescription)
                
                
                
            }
            
            snap?.documentChanges.forEach({ (change) in
                print(self.listener!)
            
                let data = change.document.data()
                let fact = Facts.init(data: data)
                
                switch change.type {
                case .added:
                    self.onDocumentAdded(change: change, fact: fact)
                case .modified:
                    self.onDocumentModified(change: change, fact: fact)
                case .removed:
                    self.onDocumentRemoved(change: change)
                    
                
                }
            })
        })
        
    }
    
    
    func setUpTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
               
        //register the xib
        tableView.register(UINib(nibName: Identifiers.FactsCell, bundle: nil), forCellReuseIdentifier: Identifiers.FactsCell)
               
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


extension FactsController: UITableViewDelegate, UITableViewDataSource {
    
    
    func onDocumentAdded(change: DocumentChange, fact: Facts) {
        
        let newIndex = Int(change.newIndex)
        facts.insert(fact, at: newIndex)
        tableView.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .fade)
        
        
    }

    func onDocumentModified(change: DocumentChange, fact: Facts) {
        if change.oldIndex == change.newIndex {
            //Item changed, but remained in the same position
            let index = Int(change.newIndex)
            facts[index] = fact
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        } else {
            //item changed and changed position
            let oldIndex = Int(change.oldIndex)
            let newIndex = Int(change.newIndex)
            facts.remove(at: oldIndex)
            facts.insert(fact, at: newIndex)
            tableView.moveRow(at: IndexPath(row: oldIndex, section: 0), to: IndexPath(row: newIndex, section: 0))
            
        }
    }

    func onDocumentRemoved(change: DocumentChange) {
        let oldIndex = Int(change.oldIndex)
        facts.remove(at: oldIndex)
        tableView.deleteRows(at: [IndexPath(row: oldIndex, section: 0)], with: .left)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facts.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.FactsCell, for: indexPath ) as? FactsCell {
            
        cell.configureCell(fact: facts[indexPath.row])
            return cell
            
            
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = FactsDetailVC()
        let selectedFact = facts[indexPath.row]
        vc.fact = selectedFact
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

 
