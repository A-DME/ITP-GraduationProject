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
    
    
    func resetOrder(draftId: Int){
        
//        print(extractLineItemsPostData(lineItems: cartItems))
        networkManager?.putInApi(url: APIHandler.urlForGetting(.draftOrder(id: "\(String(draftId))")), parameters: ["draft_order": ["line_items": ["variant_title": "cup of tee"]]])
    }
    
    func completeOrder(draftId: Int){
        
//        print(extractLineItemsPostData(lineItems: cartItems))
        networkManager?.putInApi(url: APIHandler.urlForGetting(.draftOrder(id: "\(String(draftId))")), parameters: ["draft_order": ["line_items": [
            ["title": "IPod Touch 8GB"]/*fix error here*/
        ]
                                                                                                                                   ]])
    }
    
    func postOrder(){
// MARK: - Post order from draftOrder Here
        /* line items same, get discount code from AppliedDiscount, order.createdAt = draft.updatedAt*/
        if flag == false{
            postOrder()
        }else{
            let order = Order(id: 0, lineItems: cart ?? [], createdAt: draftOrder?.updatedAt ?? "", currency: draftOrder?.currency ?? "", currentSubtotalPrice: "", name: "", subtotalPrice: "", totalPrice: "", customer: draftOrder?.customer ?? CustomerModel(first_name: "", last_name: "", email: "", phone: "", tags: "", id: 0, verified_email: false, note: ""), currentTotalDiscounts: "", totalDiscounts: "",appliedDiscount: draftOrder?.appliedDiscount)
            let parameters = HelperFunctions().convertToDictionary(object: order, String: "order") ?? [:]
            networkManager?.PostToApi(url: APIHandler.urlForGetting(.orders), parameters: parameters)
        }
    }
    
    func getDraftOrder() -> DraftOrder?{
        return draftOrder
    }
   
}
