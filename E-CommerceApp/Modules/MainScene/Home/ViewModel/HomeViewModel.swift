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
    var userDefult : Utilities?
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
        self.userDefult = Utilities()
        
    }
   
    func loadBrandCollectionData(){
        let apiUrl = APIHandler.urlForGetting(.SmartCollections)
        networkHandler?.fetch(url: apiUrl, type: Collections.self, complitionHandler: { data in
            self.Brandsresult = data
        })
    }
    func loadAdsCollectionData(){
        let apiUrl = APIHandler.urlForGetting(.priceRule)
        networkHandler?.fetch(url: apiUrl, type: PriceRules.self, complitionHandler: { data in
            self.Adsresult = data
        })
    }
    func getBrandsData()-> [SmartCollection]{
        return Brandsresult?.smartCollections ?? []
    }
    func getAdsData()->PriceRules{
        return Adsresult ?? PriceRules(priceRules: [])
    }

  func checkNetworkReachability(completion: @escaping (Bool) -> Void) {
      reachabilityHandler.checkNetworkReachability { isReachable in
          completion(isReachable)
      }
  }
    func isLoggedIn()->Bool{
        return userDefult?.isLoggedIn() ?? false
    }
}
