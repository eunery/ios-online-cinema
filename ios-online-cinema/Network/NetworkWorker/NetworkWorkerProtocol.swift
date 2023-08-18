//
//  NetworkWorkerProtocol.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 10.08.2023.
//

import Foundation

protocol NetworkWorkerProtocol {
    
    func performRequest<T: Codable>(
        queryParametres: [URLQueryItem]?,
        endpoint: String,
        apiMethod: APIMethods,
        responseType: T.Type,
        completionHandler: @escaping(Result<T, APIError>) -> Void)
}
