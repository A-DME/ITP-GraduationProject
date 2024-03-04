//
//  MeViewModel.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 21/02/2024.
//

import Foundation
class MeViewModel{
    
    var networkHandler:NetworkManager?
    var userDefult : Utilities?
    var bindResultToViewController : (()->()) = {}
    var customerItems :[Order]?
    let model = ReachabilityManager()
    var result : Orders?{
         didSet{
             bindResultToViewController()
         }
     }
    var bindWishlistToViewController : (()->()) = {}
    var wishlistResult : [LineItem]?{
         didSet{
             bindWishlistToViewController()
         }
     }
     
     init() {
         self.networkHandler = NetworkManager()
         self.userDefult = Utilities()
         customerItems = []
         
     }
    
     func loadData(){
         let apiUrl = APIHandler.urlForGetting(.orders)
         networkHandler?.fetch(url: apiUrl, type: Orders.self, complitionHandler: { data in
             self.result = data
       
         })
         
         
     }
    func loadWishlistData(){
        let apiUrl = APIHandler.urlForGetting(.draftOrder(id: "1148537569525"))
        networkHandler?.fetch(url: apiUrl, type: DraftOrderContainer.self, complitionHandler: { data in
            self.wishlistResult = data?.draftOrder.lineItems
      
        })
        
        
    }
    func getOrderData(customerId : Int)->[Order]{
       
        self.customerItems = self.result?.orders.filter{
            $0.customer.id == customerId
         } ?? []
      
         return customerItems ?? []
     }
    func getWishlistData()->[LineItem]{
        return wishlistResult ?? []
     }
    func checkNetworkReachability(completion: @escaping (Bool) -> Void) {
        model.checkNetworkReachability { isReachable in
            completion(isReachable)
        }
    }
    func getCustomerId()-> Int{
        return userDefult?.getCustomerId() ?? 0
        
    }
    func getCustomerName()-> String{
        return userDefult?.getCustomerName() ?? ""
        
    }
    func isLoggedIn()->Bool{
        return userDefult?.isLoggedIn() ?? false
    }
    
}
