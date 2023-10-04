//
//  UpdateOrgDrugModel.swift
//  CareInvoice
//
//  Created by Jotno on 10/4/23.
//

import Foundation


struct UpdateOrgDrugModel : Codable, Identifiable{
    /*
     private Long id;
      private Long orgId;
      private Long drugId;
      private Double price;
      private Long quantity;
     
     */
    
    var id : Int?
    var orgId : Int
    var drugId : Int
    var price : Double
    var quantity : Int
    
}
