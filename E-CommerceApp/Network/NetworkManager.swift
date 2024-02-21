//
//  NetworkManager.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 21/02/2024.
//

import Foundation
import Alamofire

class NetworkManager{
    func fetch<T: Codable>(url: String, type: T.Type, complitionHandler: @escaping (T?)->Void) {
        let url = URL(string:url)
        guard let newURL = url else {
            complitionHandler(nil)
            return  }
        AF.request(newURL).response { data in
            guard let data = data.data else {
                complitionHandler(nil)
                return  }
            print("fetching in background")
            do{
                let result = try JSONDecoder().decode(T.self, from: data)
                complitionHandler(result)
            }catch let error{
                print("the error is in the decoding proccess")
                print(error.localizedDescription)
                complitionHandler(nil)
            }
        }
    }
}
