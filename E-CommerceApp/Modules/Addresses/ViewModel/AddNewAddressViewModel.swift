//
//  AddNewAddressViewModel.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 01/03/2024.
//

import Foundation
class AddNewAddressViewModel{
    var networkManager: NetworkManager?
    var helper: HelperFunctions?

    init() {
        self.networkManager = NetworkManager()
        self.helper = HelperFunctions()
    }
    
    func postAddressToApi(customer_id: Int,name: String, phone: String, city: String, address: String, setDefault: Bool){
        networkManager?.PostToApi(url: APIHandler.urlForGetting(.allAddressesOf(customer_id: String(customer_id))), parameters: ["address":["name":name,"phone":phone, "address1": address, "city": city, "default": setDefault]])
    }
}
