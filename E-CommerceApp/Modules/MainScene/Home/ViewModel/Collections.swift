//
//  ProductModel.swift
//  E-CommerceApp
//
//  Created by Basma on 24/02/2024.
//

import Foundation
struct Collections: Codable {
        let smartCollections: [SmartCollection]

        enum CodingKeys: String, CodingKey {
            case smartCollections = "smart_collections"
        }
    }

    // MARK: - SmartCollection
    struct SmartCollection: Codable {
       
        let title: String
        let image: Image

        enum CodingKeys: String, CodingKey {
            case title
            case image
        }
    }

    // MARK: - Image
    struct Image: Codable {
    
        let src: String

        enum CodingKeys: String, CodingKey {
            case src
        }
    }

   
