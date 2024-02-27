//
//  Methods.swift
//  E-CommerceApp
//
//  Created by Menna Setait on 27/02/2024.
//

import Foundation
enum Methods {

    case GET
    case POST
    case PUT
    case DELETE
    
}

enum ErrorType:Error {
    
    case InternalError
    case ServerError
    case parsingError
    case urlBadFormmated
    
}

