//
//  Constants.swift
//  WasteManagement
//
//  Created by Nadia Shalaby on 2020-03-24.
//  Copyright © 2020 NadiaAigayle. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Constants {
    
    
    static let db = Firestore.firestore()
    static let organizations = db.collection("organizations")
    
    struct Storyboard {
        static let homeViewController = "HomeVC" // we only write HomeVC here so we avoid typos
        static let Main = "mainPage"
        
        static let adminHome = "adminHome"
        static let loginPage = "loginVC"
        static let orgPage = "orgVC"
        static let donationPage = "DonationsVC"
        static let moneyPage = "DonateMoneyVC"
        static let factsPage = "FactsVC"
        static let CartPage = "CartVC"
        
        
        
        
    }
    //create a get user type function to make homepage view easier for both organizations
    //and people
    func getUserType(){
        
    }
    struct AppImages {
        static let greenCheck = "green_check"
        static let redCheck = "red_check"
        static let filledStar = "filled_star"
        static let emptyStar = "empty_star"
        static let placeHolder = "AppIcon"
        
    }
    
    struct AppColors {
        static let blue = #colorLiteral(red: 0.01913057784, green: 0.199172424, blue: 0.9376126528, alpha: 1)
        static let purple = #colorLiteral(red: 0.6263155764, green: 0.09460204949, blue: 0.5173500664, alpha: 1)
    }
}

struct Identifiers {
    static let OrganizationCell = "OrgCell"
    static let donationCell = "DonationCell"
    static let MoneyCell = "MoneyCell"
    static let FactsCell = "FactsCell"
    static let CartCell = "cartItemCell"
    
    
}

struct Segues {
    static let toDonations = "ToProductsVS"
    static let toFavs = "toFavourites"
}
