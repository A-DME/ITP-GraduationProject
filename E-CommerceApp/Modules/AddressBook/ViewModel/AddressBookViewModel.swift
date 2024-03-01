//
//  AddressBook.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 21/02/2024.
//

import Foundation

class AddressBookViewModel{
    var networkManager:NetworkManager?
    var customerID = 7440718856437 // TODO: recieve customer id from current User (if found)
    var bindResultToViewController : (()->()) = {}
    let model = ReachabilityManager()
    var defaultAddress : [Address]? {
        didSet{
            bindResultToViewController()
        }
    }

     init() {
         self.networkManager = NetworkManager()
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
    
    func makeDefault(addressId: Int){
//        networkManager.putInApi(url:, parameters)
        
    }
    
    func getDefaultAddress() -> [Address]{
        return defaultAddress ?? []
    }
}
