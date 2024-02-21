//
//  ApiHandler.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 21/02/2024.
//

import Foundation

class APIHandler{
    static let storeURL = "q2-23-24-ios-sv-team2.myshopify.com"
    static let accessToken = "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"
    static let apiKey = "ea12d3c9a7ec864490ccdbb44084163a"
    static let apiSecretKey = "55023354775ac02849fce13991ff2184"
    
    enum EndPoints: String {
        case priceRule = "price_rules.json"
        case customers = "customers.json "
        case orders = "orders.json"
        case products = "products.json"
        case draftOrder = "draft_orders.json"
        case disountCode = "discount_codes.json"
    }
    
}
