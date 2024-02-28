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
         let apiUrl = APIHandler.urlForGetting(.orders)
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
