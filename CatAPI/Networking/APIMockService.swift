//
//  APIMockService.swift
//  CatAPI
//
//  Created by Glenn Karlo Manguiat on 6/6/25.
//

import Foundation

struct APIMockService: APIServiceProtocol {
    
    var result: Result<[Breed], APIError>
    
    func fetchBreeds(url: URL?, completion: @escaping (Result<[Breed], APIError>) -> Void) {
        completion(result)
    }
}
