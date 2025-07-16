//
//  CatAPITests.swift
//  CatAPITests
//
//  Created by Glenn Karlo Manguiat on 6/5/25.
//

import XCTest
import Combine
@testable import CatAPI

final class CatAPITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    var subscriptions = Set<AnyCancellable>()
    
    func test_getting_breeds_success() throws {
        let result = Result<[Breed], APIError>.success([Breed.example()]) // success
        let fetcher = BreedFetcher(service: APIMockService(result: result))
        
        let promise = expectation(description: "fetching breeds")
        
        fetcher.$breeds.sink { breeds in
            if breeds.count > 0 {
                promise.fulfill()
            }
        }.store(in: &subscriptions)
        
        wait(for: [promise], timeout: 3)
    }
    
    func test_loading_error() {
        let result = Result<[Breed], APIError>.failure(APIError.badURL) // failure
        let fetcher = BreedFetcher(service: APIMockService(result: result))
        
        let promise = expectation(description: "show error message")
        
        fetcher.$breeds.sink { breeds in
            if !breeds.isEmpty {
                XCTFail()
            }
        }.store(in: &subscriptions)
        
        
        fetcher.$errorMessage.sink { message in
             if message != nil {
                 promise.fulfill()
            }
        }.store(in: &subscriptions)
        
        wait(for: [promise], timeout: 3)
    }
}
