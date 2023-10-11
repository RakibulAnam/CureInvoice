//
//  ErrorHandlers.swift
//  CareInvoice
//
//  Created by Jotno on 10/9/23.
//

import Foundation


enum OrgUserError : Error {
    case urlProblem
    case duplicateData
    case emptyTextField
}

enum ProductError : Error {
    case emptyInfo
    
}

enum DuplicateError : Error {
    case duplicate
    
}
