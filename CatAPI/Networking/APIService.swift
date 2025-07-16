//
//  APIService.swift
//  CatAPI
//
//  Created by Glenn Karlo Manguiat on 6/5/25.
//

import Foundation

struct APIService: APIServiceProtocol {
    
    func fetch<T: Decodable>(_ type: T.Type, url: URL?, completion: @escaping (Result<T, APIError>) -> Void) {
        
        guard let url = url else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
            } else if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let result = try decoder.decode(type, from: data)
                    completion(Result.success(result))
                } catch {
                    completion(Result.failure(APIError.parsingError(error as? DecodingError)))
                }
            }
            
           
        }
        task.resume()
        
    }
    
    func fetch<T: Decodable>(_ type: T.Type, url: URL?, headers: [String:String], completion: @escaping (Result<T, APIError>) -> Void) {
        
        guard let url = url else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
            } else if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let result = try decoder.decode(type, from: data)
                    completion(Result.success(result))
                } catch {
                    completion(Result.failure(APIError.parsingError(error as? DecodingError)))
                }
            }
            
           
        }
        task.resume()
        
    }
    
    func fetchBreeds(url: URL?, completion: @escaping (Result<[Breed], APIError>) -> Void) {
        
        guard let url = url else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
            } else if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let breeds = try decoder.decode([Breed].self, from: data)
                    completion(Result.success(breeds))
                } catch {
                    completion(Result.failure(APIError.parsingError(error as? DecodingError)))
                }
            }
            
           
        }
        task.resume()
        
    }
}
