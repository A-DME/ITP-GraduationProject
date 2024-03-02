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
                print(error)
                complitionHandler(nil)
            }
        }
    }
    
    
  /*
    func registerCustomer(newCustomer: Customer, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        print("in register")
        let endpoint = APIHandler.EndPoints.customers.order
        let shopURL = APIHandler.storeURL
        let apiKey = APIHandler.apiKey
        let accessToken = APIHandler.accessToken
        
        let apiUrl = "https://\(apiKey):\(accessToken)@\(shopURL)/admin/api/2024-01/\(endpoint)"
        print("post api\(apiUrl)")
        do{
            let customer = try newCustomer.asDictionary()
            PostToApi(url: apiUrl, parameters: customer )
            print("PostToApi is called")
            print(customer)
        }catch{
            print("error in transforming customer into dictionary")
            print(error.localizedDescription)
        }
    }*/
    
    func PostToApi(url:String,parameters: Parameters){
            
            let headers: HTTPHeaders = [
                "Cookie":""
            ]
         
            let url = URL(string:url)
            guard let newURL = url else {
                return
            }
            AF.request(newURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                .response{ response in
                    switch response.result {
                    case .success:
                        if let data = response.data {
                            print("Success: \(String(data: data, encoding: .utf8) ?? "")")
                        }
                    case .failure(let error):
                        print("Error: \(error)")
                        
                        if let data = response.data {
                            print("Response Data: \(String(data: data, encoding: .utf8) ?? "")")
                        }
                    }
                }
        }
}










