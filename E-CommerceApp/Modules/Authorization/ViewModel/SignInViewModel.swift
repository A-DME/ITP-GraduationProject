//
//  SignInViewModel.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 21/02/2024.
//

import Foundation
class SignInViewModel{
    let model = ReachabilityManager()
    
    
    func checkNetworkReachability(completion: @escaping (Bool) -> Void) {
        model.checkNetworkReachability { isReachable in
            completion(isReachable)
        }
    }
//    func loadData(){
//        let endpoint = APIHandler.EndPoints.Customer(id: id)
//        let shopURL = APIHandler.storeURL
//        let apiKey = APIHandler.apiKey
//        let accessToken = APIHandler.accessToken
//
//        let apiUrl = "https://\(apiKey):\(accessToken)@\(shopURL)/admin/api/2024-01/\(endpoint)"
//        networkHandler?.fetch(url: apiUrl, type: Products.self, complitionHandler: { data in
//            self.result = data
//      
//        })
//        
//        
//    }
    
}
