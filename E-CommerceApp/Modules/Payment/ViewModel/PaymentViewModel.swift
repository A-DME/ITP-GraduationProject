//
//  PaymentViewModel.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 27/02/2024.
//

import Foundation

class PaymentViewModel{
    let paymentMethods = ["Online payment", "Cash on delivery"]
    var networkManager: NetworkManager?
    var flag = false
    var bindResultToViewController: (()->()) = {}
    var draftOrder: DraftOrder? {
        didSet{
            bindResultToViewController()
            flag = true
        }
    }
    var cart: [LineItem]?
    
    let dummyLineItem: [String: Any] = ["title": "dummy", "quantity": 1, "price": "0.0", "properties":[]]
    
    init(){
        networkManager = NetworkManager()
    }
// MARK: - Awaiting customer's cart id
    func loadData(draftId: Int){
        networkManager?.fetch(url: APIHandler.urlForGetting(.draftOrder(id: "\(String(draftId))")), type: DraftOrderContainer.self, complitionHandler: { container in
            self.draftOrder = container?.draftOrder
            self.cart = self.draftOrder?.lineItems
        })
    }
    
    func completeOrder(draftId: Int){
        
//        print(extractLineItemsPostData(lineItems: cartItems))
        networkManager?.putInApi(url: APIHandler.urlForGetting(.draftOrder(id: "\(String(draftId))")), parameters: ["draft_order": ["line_items":[dummyLineItem]]])
    }
    
//    let dummyLineItem: [String: Any] = ["title": "dummy", "quantity": 1, "price": "0.0", "properties":[]]
//    parameters: ["draft_order": ["line_items":[dummyLineItem]]]
    
    func postOrder(){
// MARK: - Post order from draftOrder Here
        /* line items same, get discount code from AppliedDiscount, order.createdAt = draft.updatedAt*/
        if flag == false{
            postOrder()
        }else{
            let order = Order(id: 0, lineItems: priceUpdatedCart(getFilteredCart()), createdAt: draftOrder?.updatedAt ?? "", currency: UserDefaults.standard.string(forKey: "currencyTitle") ?? "", currentSubtotalPrice: "", name: "", subtotalPrice: "", totalPrice: "", customer: draftOrder?.customer ?? CustomerModel(first_name: "", last_name: "", email: "", phone: "", tags: "", id: 0, verified_email: false, note: ""), currentTotalDiscounts: "", totalDiscounts: "",appliedDiscount: draftOrder?.appliedDiscount)
            let parameters = HelperFunctions().convertToDictionary(object: order, String: "order") ?? [:]
            networkManager?.PostToApi(url: APIHandler.urlForGetting(.orders), parameters: parameters)
        }
    }
    
    func getDraftOrder() -> DraftOrder?{
        return draftOrder
    }
    
    func getFilteredCart() -> [LineItem]{
        var result: [LineItem] = []
        guard let cart = cart else { return [] }
        for item in cart {
            if item.title ?? "" != "dummy" {
                result.append(item)
            }
        }
        return result
    }
    
    func priceUpdatedCart(_ cart: [LineItem]) -> [LineItem]{
        var result: [LineItem] = []
        for item in 0...cart.count-1 {
            result.append(cart[item])
            result[item].price = String(UserDefaults.standard.double(forKey: "factor") * (Double(result[item].price) ?? 0.0))
        }
        
        return result
    }
   
}
