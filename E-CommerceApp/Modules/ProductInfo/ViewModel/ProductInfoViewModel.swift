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
    init(){
        networkHandler = NetworkManager()
    }
    func getProductDetails()-> Product?{
        return product
    }
    func getProductImages()-> [ProductImage]{
        return product?.images ?? []
    }
    func getImagesCount()-> Int{
        print(product?.images.count ?? 0)
        return product?.images.count ?? 0
    }
    func loadData(productId:Int){
        let apiUrl = APIHandler.urlForGetting(.ProductDetails(id: String(productId)))
        print(apiUrl)
        networkHandler?.fetch(url: apiUrl, type: ProductContainer.self, complitionHandler: { data in
            self.product = data?.product
            print(self.product?.title ?? "default value")
      
        })
    }
    
    
}
