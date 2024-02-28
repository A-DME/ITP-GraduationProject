//
//  OrdersTableViewModel.swift
//  E-CommerceApp
//
//  Created by Basma on 28/02/2024.
//

import Foundation
class OrdersTableViewModel{
    var networkHandler:NetworkManager?
    var bindResultToViewController : (()->()) = {}
    var customerItems :[Order]?
    let model = ReachabilityManager()
    var result : Orders?{
         didSet{
             bindResultToViewController()
         }
     }
     
     init() {
         self.networkHandler = NetworkManager()
         customerItems = []
         
     }
    
     func loadData(){
         let endpoint = APIHandler.EndPoints.orders.order
         let shopURL = APIHandler.storeURL
         let apiKey = APIHandler.apiKey
         let accessToken = APIHandler.accessToken

         let apiUrl = "https://\(apiKey):\(accessToken)@\(shopURL)/admin/api/2024-01/\(endpoint)"
         networkHandler?.fetch(url: apiUrl, type: Orders.self, complitionHandler: { data in
             self.result = data
       
         })
         
         
     }
    func getAllData(customerId : Int)->[Order]{
       
        self.customerItems = self.result?.orders.filter{
            $0.customer.id == customerId
         } ?? []
      
         return customerItems ?? []
     }
    func checkNetworkReachability(completion: @escaping (Bool) -> Void) {
        model.checkNetworkReachability { isReachable in
            completion(isReachable)
        }
    }
}
