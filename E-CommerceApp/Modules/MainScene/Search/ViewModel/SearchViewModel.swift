//
//  SearchViewModel.swift
//  E-CommerceApp
//
//  Created by Basma on 03/03/2024.
//

import Foundation
class SearchViewModel{
    var networkHandler:NetworkManager?
    var bindResultToViewController : (()->()) = {}

    var result : Products?{
         didSet{
             bindResultToViewController()
         }
     }
     
     init() {
         self.networkHandler = NetworkManager()
         
     }
    
     func loadData(){
         let apiUrl = APIHandler.urlForGetting(.products)
         networkHandler?.fetch(url: apiUrl, type: Products.self, complitionHandler: { data in
             self.result = data
       
         })
         
         
     }
    func getAllData()->Products{
        return result ?? Products(products: [])
    }
}
