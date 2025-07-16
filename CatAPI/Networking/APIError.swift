//
//  APIError.swift
//  CatAPI
//
//  Created by Glenn Karlo Manguiat on 6/5/25.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
    case badURL
    case badResponse(statusCode: Int)
    case url(URLError?)
    case parsingError(DecodingError?)
    case unknown
    
    var localizedDescription: String {
        //user feedback
        
        switch self {
        case .badURL, .parsingError(_), .unknown:
            return "Something went wrong."
        case .badResponse(_):
            return "The connection to our server failed"
        case .url(let error):
            return error?.localizedDescription ?? "Unknown error"
        }
    }
    
    var description: String {
        switch self {
        case .unknown:
            return "Unknown error"
        case .badURL:
            return "Bad URL"
        case .badResponse(statusCode: let code):
            return "Bad response with status code: \(code)"
        case .url(let error):
            return "URL Error: \(String(describing: error))"
        case .parsingError (let error):
            return "Parsing Error \(error?.localizedDescription ?? "")"
        }
    }
}
