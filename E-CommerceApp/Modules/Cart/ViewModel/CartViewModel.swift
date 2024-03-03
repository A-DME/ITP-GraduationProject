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
    var cart: [LineItem]? {
        didSet{
            bindResultToViewController()
        }
    }
    
    init(){
        networkManager = NetworkManager()
    }
// MARK: - Awaiting customer's cart id
    func loadData(){
        networkManager?.fetch(url: APIHandler.urlForGetting(.draftOrder(id: "1148431433973")), type: DraftOrderContainer.self, complitionHandler: { container in
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
            result.append(["variant_id": item.variantID, "quantity": item.quantity, "properties": properties])
        }
                
        return result
    }
    
    func updateOrder(cartItems: [LineItem]?){
        guard let cartItems = cartItems else { return }
        
//        print(extractLineItemsPostData(lineItems: cartItems))
        networkManager?.putInApi(url: APIHandler.urlForGetting(.draftOrder(id: "1148431433973")), parameters: ["draft_order": ["line_items": extractLineItemsPostData(lineItems: cartItems)]])
    }
    
    func getCart() -> [LineItem]{
        return cart ?? []
    }
    
}
