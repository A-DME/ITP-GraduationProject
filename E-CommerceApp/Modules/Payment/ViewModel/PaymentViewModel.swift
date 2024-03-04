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
    var bindResultToViewController: (()->()) = {}
    var draftOrder: DraftOrder? {
        didSet{
            bindResultToViewController()
        }
    }
    
    
    init(){
        networkManager = NetworkManager()
    }
// MARK: - Awaiting customer's cart id
    func loadData(draftId: Int){
        networkManager?.fetch(url: APIHandler.urlForGetting(.draftOrder(id: "\(String(draftId))")), type: DraftOrderContainer.self, complitionHandler: { container in
            self.draftOrder = container?.draftOrder
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
    }
    
    func getDraftOrder() -> DraftOrder?{
        return draftOrder
    }
}
