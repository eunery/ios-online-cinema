//
//  NetworkWorkerProtocol.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 10.08.2023.
//

import Foundation

protocol NetworkWorkerProtocol {
    var scheme: String { get }
    var host: String { get }
    var token: String { get }
    
    func performRequest<T: Codable>(endpoint: Endpoints, apiMethod: APIMethods, responseType: T.Type, completionHandler: @escaping(Result<T, APIError>) -> Void)
}

