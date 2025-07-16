//
//  APIServiceProtocol.swift
//  CatAPI
//
//  Created by Glenn Karlo Manguiat on 6/6/25.
//

import Foundation

protocol APIServiceProtocol {
    func fetchBreeds(url: URL?, completion: @escaping (Result<[Breed], APIError>)    -> Void)
}
