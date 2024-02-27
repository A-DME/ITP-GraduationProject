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
   
    var bindBrandsResultToViewController : (()->()) = {}
    var Brandsresult :Collections? {
        didSet{
            bindBrandsResultToViewController()
        }
    }
    var bindAdsResultToViewController : (()->()) = {}
    var Adsresult :PriceRules? {
        didSet{
            bindAdsResultToViewController()
        }
    }
    
    init() {
        self.networkHandler = NetworkManager()
        
    }
   
    func loadBrandCollectionData(){
        //let endpoint = data
        let shopURL = APIHandler.storeURL
        let apiKey = APIHandler.apiKey
        let accessToken = APIHandler.accessToken

        let apiUrl = "https://\(apiKey):\(accessToken)@\(shopURL)/admin/api/2024-01/smart_collections.json"
        networkHandler?.fetch(url: apiUrl, type: Collections.self, complitionHandler: { data in
            self.Brandsresult = data
        })
    }
    func loadAdsCollectionData(){
        //let endpoint = data
        let shopURL = APIHandler.storeURL
        let apiKey = APIHandler.apiKey
        let accessToken = APIHandler.accessToken

        let apiUrl = "https://\(apiKey):\(accessToken)@\(shopURL)/admin/api/2024-01/price_rules.json"
        networkHandler?.fetch(url: apiUrl, type: PriceRules.self, complitionHandler: { data in
            self.Adsresult = data
        })
    }
    func getBrandsData()->Collections{
        return Brandsresult ?? Collections(smartCollections: [])
    }
    func getAdsData()->PriceRules{
        return Adsresult ?? PriceRules(priceRules: [])
    }

  func checkNetworkReachability(completion: @escaping (Bool) -> Void) {
      reachabilityHandler.checkNetworkReachability { isReachable in
          completion(isReachable)
      }
  }
}
