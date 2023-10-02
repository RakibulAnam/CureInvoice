//
//  DrugModel.swift
//  CareInvoice
//
//  Created by Jotno on 9/26/23.
//

import Foundation


struct DrugModel : Codable, Identifiable{
    
    /*
     
     "id": 9,
             "brandName": "Barium Sulfate",
             "price": 150.0,
             "vendorName": "AD-DIN PHARMA",
             "genericName": "ACEMETACIN",
             "formationName": "INHALER",
             "strengthName": "(1gm+500mg)/100ml"
     
     */
    
    var id : Int?
    var brandName : String
    var price : Double
    var vendorName : String
    var genericName : String
    var formationName : String
    var strengthName : String
    var quantity : Int?
    
    
    
}
