//
//  Customer.swift
//  E-CommerceApp
//
//  Created by Menna Setait on 27/02/2024.
//

import Foundation
struct AllCustomers : Codable{
    let customers: [CustomerModel]?
}

struct Customer : Codable{
    let customer: CustomerModel
}

struct CustomerModel : Codable {
    let first_name, last_name, email, phone : String?
    let id: Int?
    let verified_email: Bool?
    let password : String?
    let password_confirmation :String?
    
}

