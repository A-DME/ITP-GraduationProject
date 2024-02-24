//
//  HomeViewModel.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 21/02/2024.
//

import Foundation
class HomeViewModel{
    
   var networkHandler:NetworkManager?
   
    var bindResultToViewController : (()->()) = {}
    var result :Collections? {
        didSet{
            bindResultToViewController()
        }
    }
    
    init() {
        self.networkHandler = NetworkManager()
    }
   
    func loadData(){
        
        networkHandler?.fetch(url: "https://ea12d3c9a7ec864490ccdbb44084163a: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@q2-23-24-ios-sv-team2.myshopify.com/admin/api/2024-01/smart_collections.json", type: Collections.self, complitionHandler: { data in
            self.result = data
        })
    }
    func getData()->Collections{
        return result ?? Collections(smartCollections: [])
    }
}
