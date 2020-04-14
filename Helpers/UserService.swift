//
//  UserService.swift
//  WasteManagement
//
//  Created by Nadia Shalaby on 2020-04-03.
//  Copyright © 2020 NadiaAigayle. All rights reserved.
//


import Foundation
import FirebaseAuth
import FirebaseFirestore

let UserService = _UserService()

final class _UserService {
    
    // Variables
    var user = User()
    var favorites = [Organizations]()
    let auth = Auth.auth()
    let db = Firestore.firestore()
    var userListener : ListenerRegistration? = nil
    var favsListener : ListenerRegistration? = nil
    
    /*var isGuest : Bool {
        //getting the guest auth
        guard let authUser = auth.currentUser else {
            return true
        }
        if authUser.isAnonymous {
            return true
        } else {
            return false
        }
    }*/
    
    func getCurrentUser() {
       guard let authUser = auth.currentUser else { return }
        
        let userRef = db.collection("users").document(authUser.uid)
        userListener = userRef.addSnapshotListener({ (snap, error) in
            
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            
            guard let data = snap?.data() else { return }
            self.user = User.init(data: data)
            print(self.user)
        })
        
        let favsRef = userRef.collection("favourites")
        favsListener = favsRef.addSnapshotListener({ (snap, error) in
            
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            
            snap?.documents.forEach({ (document) in
                let favorite = Organizations.init(data: document.data())
                self.favorites.append(favorite)
            })
        })
    }
    
    func favoriteSelected(organization: Organizations) {
        let favsRef = Firestore.firestore().collection("users").document(user.id).collection("favourites")
        
        if favorites.contains(organization) {
            // We remove it as a favorite
            favorites.removeAll{$0 == organization}
            favsRef.document(organization.id).delete()
        } else {
            // Add as a favorite.
            favorites.append(organization)
            let data = Organizations.modelToData(organization: organization)
            favsRef.document(organization.id).setData(data)
        }
    }
    
    func logoutUser() {
        userListener?.remove()
        userListener = nil
        favsListener?.remove()
        favsListener = nil
        user = User()
        favorites.removeAll()
    }
}
