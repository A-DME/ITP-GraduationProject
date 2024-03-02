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
    
    func deleteAddress(_ index: Int){
        networkManager?.deleteFromApi(url: APIHandler.urlForGetting(.address(customer_id: String(customerID), address_id: String(addresses![index].id))))
    }
    
    func makeDefault(index: Int){
        networkManager?.putInApi(url: APIHandler.urlForGetting(.makeDefaultAddress(customer_id: String(customerID), address_id: String(addresses![index].id))))
        
    }
    
    func getAddresses() -> [Address]{
        return addresses ?? []
    }

}


