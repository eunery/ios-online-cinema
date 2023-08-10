//
//  NetworkWorker.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 10.08.2023.
//

import Foundation

class NetworkWorker: NetworkWorkerProtocol {
    let token: String = Constants.apiKey
    let scheme: String = "https"
    let host: String = "api.themoviedb.org"
    let decoder = JSONDecoder()
    
    func performRequest<T: Codable>(endpoint: Endpoints, apiMethod: APIMethods, responseType: T.Type, completionHandler: @escaping(Result<T, APIError>) -> Void) {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = endpoint.rawValue
        
        guard let url = components.url else {
            completionHandler(Result.failure(APIError.badURL))
            return
        }
        
        let headers = [
            "accept": "application/json",
            "Authorization": "\(self.token)"
        ]
        var request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalCacheData
        )
        
        request.httpMethod = apiMethod.rawValue
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error as? URLError {
                completionHandler(Result.failure(APIError.url(error)))
            } else if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                completionHandler(Result.failure(APIError.badResponse(statusCode: httpResponse.statusCode)))
            } else if let data = data {
                do {
                    let response = try self.decoder.decode(responseType.self, from: data)
                    completionHandler(Result.success(response))
                } catch {
                    completionHandler(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }
        task.resume()
    }
}
