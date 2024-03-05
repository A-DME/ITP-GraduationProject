//
//  AddressBook.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 21/02/2024.
//

import Foundation

class AddressBookViewModel{
    var networkManager:NetworkManager?
    let model = ReachabilityManager()
    var customerID = 7440718856437 // TODO: recieve customer id from current User (if found)
    var bindResultToViewController : (()->()) = {}
    var defaultAddress : [Address]? {
        didSet{
            bindResultToViewController()
        }
    }

     init() {
         self.networkManager = NetworkManager()
     }

  func checkNetworkReachability(completion: @escaping (Bool) -> Void) {
      model.checkNetworkReachability { isReachable in
          completion(isReachable)
      }
  }
    
    func loadData(){
// MARK: - Todo: Put current customer's id
        networkManager?.fetch(url: APIHandler.urlForGetting(.allAddressesOf(customer_id: String(customerID))), type: Addresses.self, complitionHandler: { result in
            for address in result?.addresses ?? []{
                if address.addressDefault {
                    self.defaultAddress = [address]
                    break
                }
            }
        })
    }
    
    
    func addCustomerAddress(draftId: Int){
//        print(HelperFunctions().convertToDictionary(object: (defaultAddress![0]), String: "shipping_address"))
        print("updating address....")
        networkManager?.putInApi(url: APIHandler.urlForGetting(.draftOrder(id: "\(String(draftId))")), parameters:["draft_order": ["customer": ["id": defaultAddress?[0].customerID]]])
    }
    
    func getDefaultAddress() -> [Address]{
        return defaultAddress ?? []
    }
}
