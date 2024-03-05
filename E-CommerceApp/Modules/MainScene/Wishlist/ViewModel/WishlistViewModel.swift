//
//  WishlistViewModel.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 21/02/2024.
//

import Foundation
class WishlistViewModel{
    
    var networkHandler:NetworkManager?
    var userDefult : Utilities?
    let model = ReachabilityManager()

    var bindWishlistToViewController : (()->()) = {}
    var wishlistResult : [LineItem]?{
         didSet{
             bindWishlistToViewController()
         }
     }
     
     init() {
         self.networkHandler = NetworkManager()
         self.userDefult = Utilities()

         
     }
    
    func loadWishlistData(){
        let apiUrl = APIHandler.urlForGetting(.draftOrder(id: "1148537569525"))
        networkHandler?.fetch(url: apiUrl, type: DraftOrderContainer.self, complitionHandler: { data in
            self.wishlistResult = data?.draftOrder.lineItems
      
        })
        
        
    }
    func getWishlistData()->[LineItem]{
        return wishlistResult ?? []
     }
    func checkNetworkReachability(completion: @escaping (Bool) -> Void) {
        model.checkNetworkReachability { isReachable in
            completion(isReachable)
        }
    }

    func isLoggedIn()->Bool{
        return userDefult?.isLoggedIn() ?? false
    }
    
}
