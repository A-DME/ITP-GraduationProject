//
//  AddressesViewModel.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 21/02/2024.
//

import Foundation
 
class AddressesViewModel{
    
    var addresses = [Address(name: "Basma", city: "Cairo", address: "Ain Shams"),
                     Address(name: "Menna", city: "Dammieta", address: "Msh 3aref Besara7a"),
                     Address(name: "Ahmed", city: "Cairo", address: "Dar El Salam")
    ]
}


struct Address{
    var name: String
    var city: String
    var address: String
}
