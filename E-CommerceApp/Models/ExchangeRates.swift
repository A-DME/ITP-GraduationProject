//
//  ExchangeRates.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 03/03/2024.
//

import Foundation

// MARK: - ExchangeRates
struct ExchangeRates: Codable {
    let success: Bool
    let timestamp: Int
    let source: String
    let quotes: [String: Double]
}
