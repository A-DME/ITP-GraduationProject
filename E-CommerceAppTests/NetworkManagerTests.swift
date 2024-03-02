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
    let dummyCustomerId = "7440718856437"
    let dummyName = "James Bond"
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
        let apiUrl = APIHandler.urlForGetting(.allAddressesOf(customer_id: dummyCustomerId))
        let parameters = ["address":["name": name,"phone": "007", "address1": "No time to write", "city": "No way home"]]
        networkManager.PostToApi(url: apiUrl, parameters: parameters)
        Thread.sleep(forTimeInterval: 3)
        networkManager.fetch(url: APIHandler.urlForGetting(.allAddressesOf(customer_id: dummyCustomerId)), type: Addresses.self) { addressesContainer in
            for address in (addressesContainer?.addresses) ?? [] {
                if address.name == self.dummyName {
                    print(address.name)
                    expectation.fulfill()
                    break
                }
            }
        }
        waitForExpectations(timeout: 30, handler: nil)
        
    }
    
    func testPutFunction(){
        let expectation = self.expectation(description: "Network request expectation")
        var addressID: String?
        let queue = DispatchQueue(label: "Serially Do")
        queue.async {
            let group = DispatchGroup()
            
            group.enter()
            self.networkManager.fetch(url: APIHandler.urlForGetting(.allAddressesOf(customer_id: self.dummyCustomerId)), type: Addresses.self) { addressesContainer in
                for address in (addressesContainer?.addresses) ?? [] {
                    if address.name == self.dummyName {
                        print("\(address.name) assigninig id")
                        addressID = String(address.id)
                        group.leave()
                        break
                    }
                }
            }
            group.wait()
            
            let apiUrl = APIHandler.urlForGetting(.makeDefaultAddress(customer_id: self.dummyCustomerId, address_id: addressID ?? ""))
            self.networkManager.putInApi(url: apiUrl)
            
            group.enter()
            Thread.sleep(forTimeInterval: 3)
            self.networkManager.fetch(url: APIHandler.urlForGetting(.allAddressesOf(customer_id: self.dummyCustomerId)), type: Addresses.self) { addressesContainer in
                for address in (addressesContainer?.addresses) ?? [] {
                    if String(address.id) == addressID ?? "" {
                            print(address.id)
                        XCTAssertTrue(address.addressDefault, "Put not working properly")
                            expectation.fulfill()
                            group.leave()
                            break
                    }
                }
            }
            group.wait()
        }
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
