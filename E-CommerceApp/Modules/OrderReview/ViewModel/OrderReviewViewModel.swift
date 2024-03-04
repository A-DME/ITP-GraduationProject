//
//  OrderReviewViewModel.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 21/02/2024.
//

import Foundation

class OrderReviewViewModel{
    var networkManager: NetworkManager?
    var bindResultToViewController: (()->()) = {}
    let model = ReachabilityManager()
    var cart: [LineItem]? {
        didSet{
            bindResultToViewController()
        }
    }
    
    init(){
        networkManager = NetworkManager()
    }

  func checkNetworkReachability(completion: @escaping (Bool) -> Void) {
      model.checkNetworkReachability { isReachable in
          completion(isReachable)
      }
  }
// MARK: - Awaiting customer's cart id
    func loadData(draftId: Int){
        networkManager?.fetch(url: APIHandler.urlForGetting(.draftOrder(id: "\(String(draftId))")), type: DraftOrderContainer.self, complitionHandler: { container in
            self.cart = container?.draftOrder.lineItems
        })
    }
    
    
    func apply(discount: PriceRule){
//        guard let cartItems = cartItems else { return }
//        
////        print(extractLineItemsPostData(lineItems: cartItems))
//        networkManager?.putInApi(url: APIHandler.urlForGetting(.draftOrder(id: "\(String(dummyDraftId))")), parameters: ["draft_order": ["line_items": extractLineItemsPostData(lineItems: cartItems)]])
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
}
