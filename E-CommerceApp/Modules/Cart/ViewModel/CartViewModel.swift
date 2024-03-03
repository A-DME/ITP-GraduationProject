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
    
//    var cart = [CartProduct(name: "productName 1", price: 46, quantity: 4, availableQuantity: 5, img: "ad"),
//                CartProduct(name: "productName 2", price: 88, quantity: 2, availableQuantity: 3, img: "ad")]
    init(){
        networkManager = NetworkManager()
    }
    
    func loadData(){
        networkManager?.fetch(url: APIHandler.urlForGetting(.draftOrder(id: "1148388933877")), type: DraftOrderContainer.self, complitionHandler: { container in
            self.cart = container?.draftOrder.lineItems
        })
    }
    
    func getCart() -> [LineItem]{
        return cart ?? []
    }
    
}

struct CartProduct{
    var name: String
    var price: Double
    var quantity: Int
    var availableQuantity: Int
    var img: String
}
