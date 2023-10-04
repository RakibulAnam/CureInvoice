//
//  DoctorModel.swift
//  CareInvoice
//
//  Created by Jotno on 10/3/23.
//

import Foundation

struct DoctorModel : Codable, Identifiable{
    
    
    var id : Int?
    var name : String
    var degrees : String
    var contact : String
    var email : String
    var followUp : String
    var consultation : String
    var minDiscount : String
    var maxDiscount : String
    var doctorSlotDTOList : [Slot]
    var orgId : [Int]
    var spId : [Int]
    
    
    /*
    {
        "id": 3,
        "name": "Dr.Junayed",
        "degrees": "asd MSC",
        "contact": "+1 (123) 456-7890",
        "email": "jfghy@example.com",
        "followUp": "400",
        "consultation": "50.0",
        "minDiscount": "10.0",
        "maxDiscount": "20.0",
        "doctorSlotDTOList": [
            {
                "id": 15,
                "day": "Thursday",
                "time": "09:00 AM - 11:00 AM"
            },
            {
                "id": 16,
                "day": "Sunday",
                "time": "02:00 PM - 04:00 PM"
            }
        ],
        "orgId": [
            1
        ],
        "spId": [
            1
        ]
    }
    */
    
}

struct Slot : Codable, Hashable, Identifiable{
    var id : Int?
    var day : String
    var time : String
}
