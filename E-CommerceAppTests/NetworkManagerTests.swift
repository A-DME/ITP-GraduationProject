//
//  NetworkManagerTests.swift
//  E-CommerceAppTests
//
//  Created by Ahmed Abu-zeid on 28/02/2024.
//

import XCTest
@testable import E_CommerceApp

final class NetworkManagerTests: XCTestCase {

    var networkManager = NetworkManager()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchingProducts(){
        let endpoint = APIHandler.EndPoints.products.order
        let shopURL = APIHandler.storeURL
        let apiKey = APIHandler.apiKey
        let accessToken = APIHandler.accessToken

        let apiUrl = "https://\(apiKey):\(accessToken)@\(shopURL)/admin/api/2024-01/\(endpoint)"
        networkManager.fetch(url: apiUrl, type: Products.self) { productsContainer in
            XCTAssertNotNil(productsContainer, "productsContainer came empty")
        }
    }

}
