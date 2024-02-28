//
//  Orders.swift
//  E-CommerceApp
//
//  Created by Basma on 28/02/2024.
//

import Foundation


// MARK: - Welcome
struct Orders: Codable {
    var orders: [Order]
}

// MARK: - Order
struct Order: Codable {
    let id: Int
    let lineItems: [LineItem]
    let createdAt: String
    let currency: String
    let currentSubtotalPrice: String
    let name: String
    let subtotalPrice: String
    let totalPrice: String
    let customer: CustomerDetails
    let currentTotalDiscounts: String
    let totalDiscounts: String
    let discountCodes: [DiscountCode]
   
    enum CodingKeys: String, CodingKey {
        case id
        case lineItems = "line_items"
        case createdAt = "created_at"
        case currency
        case currentSubtotalPrice = "current_subtotal_price"
        case name
        case totalDiscounts = "total_discounts"
        case customer
        case currentTotalDiscounts = "current_total_discounts"
        case totalPrice = "total_price"
        case subtotalPrice = "subtotal_price"
        case discountCodes = "discount_codes"
        
      
    }
}
struct LineItem: Codable {
    let id: Int
    let name, price: String
    let quantity: Int


    enum CodingKeys: String, CodingKey {
        case id
        case name, price
        case quantity
        
    }
}
struct CustomerDetails: Codable {
    let id: Int
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case id, email

    }
}






// MARK: - DiscountCode
struct DiscountCode: Codable {
    let code, amount, type: String
}

