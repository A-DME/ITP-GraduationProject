//
//  ProductInfoViewModel.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 21/02/2024.
//

import Foundation
class ProductInfoViewModel{
    
    var networkHandler:NetworkManager?
    
    var bindResultToViewController : (()->()) = {}
    
    var product : Product?{
        didSet{
            bindResultToViewController()
        }
    }
    
    func getProductDetails()-> Product?{
        return product
    }
    
    func loadData(productId:Int){
        let apiUrl = APIHandler.urlForGetting(.ProductDetails(id: String(productId)))
        networkHandler?.fetch(url: apiUrl, type: Product.self, complitionHandler: { data in
            self.product = data
      
        })
    }
    
    
}
