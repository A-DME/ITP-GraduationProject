//
//  ProductInfoViewModel.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 21/02/2024.
//

import Foundation
class ProductInfoViewModel{
    let dummyLineItem: [String: Any] = ["title": "dummy", "quantity": 1, "price": "0.0", "properties":[]]
    var networkHandler:NetworkManager?
    
    var userDefaults : Utilities?
    
    var bindResultToViewController : (()->()) = {}
    
    var product : Product?{
        didSet{
            bindResultToViewController()
        }
    }
    init(){
        networkHandler = NetworkManager()
        userDefaults = Utilities()
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
    
    func extractLineItemsPostData(lineItems: [LineItem]) -> [[String: Any]]{
        var result: [[String: Any]] = []
        for item in lineItems{
            var properties : [[String: String]] = []
            for property in item.properties {
                properties.append(["name":property.name, "value": property.value])
            }
            result.append(["variant_id": item.variantID ?? 0, "quantity": item.quantity, "properties": properties])
        }
        return result
    }
    
    //["draft_order": ["line_items": cartItems.count != 0 ? extractLineItemsPostData(lineItems: cartItems)
    
    
    func updateCartItems(cartItems: [LineItem]?){
        guard let cartItems = cartItems else { return }
        print(extractLineItemsPostData(lineItems: cartItems))
        networkHandler?.putInApi(url: APIHandler.urlForGetting(.draftOrder(id: self.userDefaults?.getCartID() ?? "")), parameters: ["draft_order": ["line_items": cartItems.count != 0 ? extractLineItemsPostData(lineItems: cartItems) : [dummyLineItem]]])
        Thread.sleep(forTimeInterval: 1)
        
        
    }
    
    func updateWishlist(wishItems: [LineItem]?){
        guard let wishItems = wishItems else { return }
        print(extractLineItemsPostData(lineItems: wishItems))
        networkHandler?.putInApi(url: APIHandler.urlForGetting(.draftOrder(id: self.userDefaults?.getWishlistID() ?? "")), parameters: ["draft_order": ["line_items": wishItems.count != 0 ? extractLineItemsPostData(lineItems: wishItems) : [dummyLineItem]]])
    }

}
