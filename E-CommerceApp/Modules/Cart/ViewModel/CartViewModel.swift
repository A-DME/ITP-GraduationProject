//
//  CartViewModel.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 21/02/2024.
//

import Foundation

class CartViewModel{
    var bindResultToViewController: (()->()) = {}
    var totalPrice: Double? {
        didSet{
            bindResultToViewController()
        }
    }
    
    var cart = [CartProduct(name: "productName 1", price: 46, quantity: 1, img: "ad"),
                CartProduct(name: "productName 2", price: 88, quantity: 2, img: "ad")]
    init(){
        calculateTotalPrice()
    }
    
    func calculateTotalPrice(){
        totalPrice = 0
        for product in cart{
            totalPrice! += product.price * Double(product.quantity)
        }
    }
}

struct CartProduct{
    var name: String
    var price: Double
    var quantity: Int
    var img: String
}
