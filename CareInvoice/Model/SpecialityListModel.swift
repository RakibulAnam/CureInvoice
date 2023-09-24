//
//  SpecialityModel.swift
//  CareInvoice
//
//  Created by Jotno on 9/24/23.
//

import Foundation


struct SpecialityListModel : Codable, Identifiable {
    
    var id : Int?
    let medSpecName : String
    let iconUrl : String
    
}
