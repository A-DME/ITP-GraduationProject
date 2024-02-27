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
    
    enum EndPoints {
        case priceRule
        case customers
        case Customer(id: String)
        case orders
        case products
        case draftOrder
        case discountCode
        case CollectionID(id:String)
        case ProductDetails(id:String)
        case SmartCollections
        var order:String{
            switch self{
            case .priceRule:
                return "price_rules.json"
            case .customers:
                return"customers.json "
            case .Customer(id: let id):
                return "customers/\(id).json"
            case .orders:
                return "orders.json"
            case .products:
                return "products.json"
            case .draftOrder:
                return "draft_orders.json"
            case .discountCode:
                return "discount_codes.json"
            case .CollectionID(id: let collectionId):
                return "products.json?collection_id=\(collectionId)"
            case .ProductDetails(id: let productId):
                return "products/\(productId).json"
            case .SmartCollections:
                return "smart_collections.json"
                
            }
        }
    }
    
}
