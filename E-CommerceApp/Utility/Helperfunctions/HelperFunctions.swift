//
//  HelperFunctions.swift
//  E-CommerceApp
//
//  Created by Basma on 29/02/2024.
//

import Foundation
class HelperFunctions{
    func convertToDictionary<T: Codable>(object: T,String: String) -> [String: Any]? {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            guard let data = try? encoder.encode(object),
                  let dictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                return nil
            }
            return [String : dictionary]
        }
}
