//
//  HomeViewModel.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 21/02/2024.
//

import Foundation
class HomeViewModel{
    
    var networkHandler:NetworkManager?
    let reachabilityHandler = ReachabilityManager()
   
    var bindResultToViewController : (()->()) = {}
    var result :Collections? {
        didSet{
            bindResultToViewController()
        }
    }
    
    init() {
        self.networkHandler = NetworkManager()
        
    }
   
    func loadData(){
        //let endpoint = APIHandler.EndPoints.products.rawValue
        let shopURL = APIHandler.storeURL
        let apiKey = APIHandler.apiKey
        let accessToken = APIHandler.accessToken

        let apiUrl = "https://\(apiKey):\(accessToken)@\(shopURL)/admin/api/2024-01/smart_collections.json"
        networkHandler?.fetch(url: apiUrl, type: Collections.self, complitionHandler: { data in
            self.result = data
        })
    }
    func getData()->Collections{
        return result ?? Collections(smartCollections: [])
    }
    

  func checkNetworkReachability(completion: @escaping (Bool) -> Void) {
      reachabilityHandler.checkNetworkReachability { isReachable in
          completion(isReachable)
      }
  }
}
