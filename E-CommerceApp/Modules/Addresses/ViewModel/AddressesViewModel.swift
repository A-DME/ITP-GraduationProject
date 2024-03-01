//
//  AddressesViewModel.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 21/02/2024.
//

import Foundation
 
class AddressesViewModel{
    var networkManager:NetworkManager?
    var customer_id: Int? // TODO: recieve customer id from previous screen
    var bindResultToViewController : (()->()) = {}
    var customerID = 7440718856437
    var addresses : [Address]? {
        didSet{
            bindResultToViewController()
        }
    }

     init() {
         self.networkManager = NetworkManager()
         addresses = []
         
     }
    
    func loadData(){
// MARK: - Todo: Put current customer's id
        networkManager?.fetch(url: APIHandler.urlForGetting(.allAddressesOf(customer_id: String(customerID))), type: Addresses.self, complitionHandler: { result in
            self.addresses = result?.addresses
        })
    }
    
    func makeDefault(addressId: Int){
//        networkManager.putInApi(url:, parameters)
        
    }
    
    func getAddresses() -> [Address]{
        return addresses ?? []
    }

}


