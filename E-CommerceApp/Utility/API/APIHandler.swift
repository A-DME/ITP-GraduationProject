//
//  ApiHandler.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 21/02/2024.
//

import Foundation

class APIHandler{
    static let ssl = "https://"
    static let storeURL = "q2-24-team2.myshopify.com"
    static let accessToken = "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"
    static let apiKey = "a73c5fc1c095fd186d957dd2093e9006"
    static let apiSecretKey = "dfd0e137695430eb82bc3bc3edbc3a30"
    
    enum EndPoints {
        case priceRule
        case customers
        case Customer(id: String)
        case allAddressesOf(customer_id: String)
        case address(customer_id: String, address_id: String)
        case orders
        case order(id: String)
        case products
        case draftOrders
        case draftOrder(id: String)
        case discountCode
        case CollectionID(id:String)
        case ProductDetails(id:String)
        case SmartCollections
        case shopConfiguration
        var order:String{
            switch self{
            case .priceRule:
                return "price_rules.json"
            case .customers:
                return"customers.json "
            case .Customer(id: let id):
                return "customers/\(id).json"
            case .allAddressesOf(customer_id: let customer_id):
                return "customers/\(customer_id)/addresses.json"
            case .address(customer_id: let customer_id, address_id: let address_id):
                return "customers/\(customer_id)/addresses/\(address_id).json"
            case .orders:
                return "orders.json"
            case .order(id: let id):
                return "orders/\(id).json"
            case .products:
                return "products.json"
            case .draftOrders:
                return "draft_orders.json"
            case .draftOrder(id: let id):
                return "draft_orders/\(id).json"
            case .discountCode:
                return "discount_codes.json"
            case .CollectionID(id: let collectionId):
                return "products.json?collection_id=\(collectionId)"
            case .ProductDetails(id: let productId):
                return "products/\(productId).json"
            case .SmartCollections:
                return "smart_collections.json"
            case .shopConfiguration:
                return "shop.json"
                
            }
        }
    }
    
    enum Completions: String{
        case ssl = "https://"
        case api_version = "2024-01"
    }
    
    class func urlForGetting(_ endpoint: EndPoints) -> String {
        return "\(Completions.ssl.rawValue)\(apiKey):\(accessToken)@\(storeURL)/admin/api/\(Completions.api_version.rawValue)/\(endpoint.order)"
    }
    
}
