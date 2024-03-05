//
//  CartViewModel.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 21/02/2024.
//

import Foundation
class CartViewModel{
    var networkManager: NetworkManager?
    var bindResultToViewController: (()->()) = {}
    let model = ReachabilityManager()
    var cart: [LineItem]? {
        didSet{
            bindResultToViewController()
        }
    }
    let dummyDraftId = 1148431433973
    
    let dummyLineItem: [String: Any] = ["title": "dummy", "quantity": 1, "price": "0.0", "properties":[]]
    
    init(){
        networkManager = NetworkManager()
    }
    
    func checkNetworkReachability(completion: @escaping (Bool) -> Void) {
        model.checkNetworkReachability { isReachable in
            completion(isReachable)
        }
    }
// MARK: - Awaiting customer's cart id
    func loadData(){
        networkManager?.fetch(url: APIHandler.urlForGetting(.draftOrder(id: "\(String(dummyDraftId))")), type: DraftOrderContainer.self, complitionHandler: { container in
            self.cart = container?.draftOrder.lineItems
        })
    }
    
    func extractLineItemsPostData(lineItems: [LineItem]) -> [[String: Any]]{
        var result: [[String: Any]] = []
        for item in lineItems{
            var properties : [[String: String]] = []
            for property in item.properties {
                properties.append(["name":property.name, "value": property.value])
            }
            result.append(["variant_id": item.variantID ?? 0, "quantity": item.quantity, "properties": properties])
        }
                
        return result
    }
    
    func updateOrder(cartItems: [LineItem]?){
        guard let cartItems = cartItems else { return }
        
//        print(extractLineItemsPostData(lineItems: cartItems))
        networkManager?.putInApi(url: APIHandler.urlForGetting(.draftOrder(id: "\(String(dummyDraftId))")), parameters: ["draft_order": ["line_items": cartItems.count != 0 ? extractLineItemsPostData(lineItems: cartItems) : [dummyLineItem]]])
    }
    
    func getFilteredCart() -> [LineItem]{
        var result: [LineItem] = []
        guard let cart = cart else { return [] }
        print(cart.count)
        for item in cart {
            if item.title ?? "" != "dummy" {
                result.append(item)
            }
        }
        print(result.count)
        return result
    }
    
}
