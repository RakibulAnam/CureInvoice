//
//  ServiceModel.swift
//  CareInvoice
//
//  Created by Jotno on 9/24/23.
//

import Foundation


struct ServiceModel : Codable, Identifiable{
    /*
    "serviceId":"1",
                    "serviceName":"Skin Biopsy",
                    "serviceCharge":"6000"
    */
    
    var id: Int?
    let serviceName : String
    let serviceCharge : String
    
    
    
}
