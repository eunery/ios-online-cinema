//
//  APIError.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 04.08.2023.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
    case badURL
    case badResponse(statusCode: Int)
    case url(URLError?)
    case parsing(DecodingError?)
    case unknown
        
    var localizedDescription: String {
        
        switch self {
        case .badURL:
            return "Invalid url. Check credentials."
        case .parsing(let error):
            return "Parsing error. \(error)"
        case .unknown:
            return "Unknown error."
        case .badResponse(let statusCode):
            return "Bad Response. Status code: \(statusCode)"
        case .url(let error):
            return error?.localizedDescription ?? "Something went wrong"
        }
    }
        
    var description: String {
        switch self {
        case .unknown: return "unknown error"
        case .badURL: return "invalid URL"
        case .url(let error):
            return error?.localizedDescription ?? "url session error"
            
        case .badResponse(statusCode: let statusCode):
            return "bad response \(statusCode)"
        case .parsing(let error):
            return "parsing error \(error?.localizedDescription ?? "")"
        }
    }
}
