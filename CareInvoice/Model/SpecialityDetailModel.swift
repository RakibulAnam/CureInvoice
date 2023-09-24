//
//  SpecialityDetailModel.swift
//  CareInvoice
//
//  Created by Jotno on 9/24/23.
//

import Foundation

struct SpecialityDetailModel : Codable, Identifiable{
    
    /*
    
medSpecId:any;
    medSpecName:string;
    compounderId:string;
    compounderName:string;
    compounderContact:string;
    doctors:[{
        doctorId:any;
        doctorName:string;
        doctorDegree:string;
    }];
    patients:[{
        patientId:any,
        patientName:string,
        age: string,
        since:string,
        medSpecName:string,
        doctorId:any,
        doctorName:string
    }]
    
    
    */
    var id : Int?
    var doctor : [DoctorModel]
    var patients : [PatientModel]
    var services : [ServiceModel]
    
}

struct DoctorModel : Codable, Identifiable{
  
    
    
    var id : Int?
    let doctorName : String
    let doctorDegree : String
}

struct PatientModel : Codable, Identifiable{
    
    var id : Int?
    let patientName : String
    let age : String
    let since : String
    let medSpecName : String
    let doctorId : Int
    let doctorName : String
    
}
