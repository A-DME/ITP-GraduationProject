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

    func testFetchingToPass(){
        
        let expectation = self.expectation(description: "Network request expectation")
        let apiUrl = APIHandler.urlForGetting(.products)
        networkManager.fetch(url: apiUrl, type: Products.self) { result in
            XCTAssertNotNil(result, "productsContainer came empty")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 30, handler: nil)
    }
    func testFetchingToFail(){
        let expectation = self.expectation(description: "Network request expectation")
        let apiUrl = "https://a73c5fc1c095fd186d957dd2093e9006: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@q2-24-team2.myshopify.com/admin/api/2024-01/produ.json"
        networkManager.fetch(url: apiUrl, type: Products.self) { productsContainer in
            XCTAssertNil(productsContainer, "productsContainer came empty")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 30, handler: nil)
    }
    func testFetchingfaildecoding(){
        
        let expectation = self.expectation(description: "Network request expectation")
        let apiUrl = APIHandler.urlForGetting(.products)
        networkManager.fetch(url: apiUrl, type: Customer.self) { productsContainer in
            XCTAssertNil(productsContainer, "productsContainer came empty")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 30, handler: nil)
    }

    func testPostFunction(){
        let expectation = self.expectation(description: "Network request expectation")
        let apiUrl = APIHandler.urlForGetting(.priceRule)
        let parameters = [
            "price_rule": [
                "id": 1171014352961,
                "value_type": "percentage",
                "value": "-25.0",
                "customer_selection": "all",
                "target_type": "line_item",
                "target_selection": "all",
                "allocation_method": "across",
                "allocation_limit": nil,
                "once_per_customer": false,
                "usage_limit": nil,
                "starts_at": "2024-02-15T03:15:09-05:00",
                "ends_at": "2024-05-01T12:00:00-04:00",
                "created_at": "2024-02-17T09:35:36-05:00",
                "updated_at": "2024-02-17T09:35:36-05:00",
                "entitled_product_ids": [],
                "entitled_variant_ids": [],
                "entitled_collection_ids": [],
                "entitled_country_ids": [],
                "prerequisite_product_ids": [],
                "prerequisite_variant_ids": [],
                "prerequisite_collection_ids": [],
                "customer_segment_prerequisite_ids": [],
                "prerequisite_customer_ids": [],
                "prerequisite_subtotal_range": nil,
                "prerequisite_quantity_range": nil,
                "prerequisite_shipping_price_range": nil,
                "prerequisite_to_entitlement_quantity_ratio": [
                    "prerequisite_quantity": nil,
                    "entitled_quantity": nil
                ],
                "prerequisite_to_entitlement_purchase": [
                    "prerequisite_amount": nil
                ],
                "title": "5%OFF",
                "admin_graphql_api_id": "gid://shopify/PriceRule/1171014352961"
            ]
        ]
        networkManager.PostToApi(url: apiUrl, parameters: parameters)
        expectation.fulfill()
        waitForExpectations(timeout: 30, handler: nil)
        
    }
    func testDeleteFromApi(){
        let expectation = self.expectation(description: "Network request expectation")
        networkManager.deleteFromApi(url: APIHandler.urlForGetting(.priceRules(id: "1171014352961")))
            expectation.fulfill()
        waitForExpectations(timeout: 30) { error in
             XCTAssertNil(error, "Timeout waiting for API request")
        }
    }
    func testDeleteFromApiFail(){
        let expectation = self.expectation(description: "Network request expectation")
        networkManager.deleteFromApi(url: APIHandler.urlForGetting(.priceRule))
        expectation.fulfill()
        waitForExpectations(timeout: 30) { error in
             XCTAssertNil(error, "Timeout waiting for API request")
        }
    }

}
