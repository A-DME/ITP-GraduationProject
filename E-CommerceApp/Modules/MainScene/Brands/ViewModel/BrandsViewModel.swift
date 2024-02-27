//
//  BrandsViewModel.swift
//  E-CommerceApp
//
//  Created by Basma on 25/02/2024.
//

import Foundation
class BrandsViewModel{
    var networkHandler:NetworkManager?
    var bindResultToViewController : (()->()) = {}
    var brand :[Product]?
    let model = ReachabilityManager()
    var result : Products?{
         didSet{
             bindResultToViewController()
         }
     }
     
     init() {
         self.networkHandler = NetworkManager()
         brand = []
         
     }
    
     func loadData(){
         let endpoint = APIHandler.EndPoints.products.rawValue
         let shopURL = APIHandler.storeURL
         let apiKey = APIHandler.apiKey
         let accessToken = APIHandler.accessToken

         let apiUrl = "https://\(apiKey):\(accessToken)@\(shopURL)/admin/api/2024-01/\(endpoint)"
         networkHandler?.fetch(url: apiUrl, type: Products.self, complitionHandler: { data in
             self.result = data
       
         })
         
         
     }
    func getAllData(vendor : String)->[Product]{
       
         self.brand = self.result?.products.filter{
             $0.vendor == vendor
         } ?? []
      
         return brand ?? []
     }
    func checkNetworkReachability(completion: @escaping (Bool) -> Void) {
        model.checkNetworkReachability { isReachable in
            completion(isReachable)
        }
    }
}
