//
//  APIService.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 04.08.2023.
//

import Foundation

struct APIService: APIServiceProtocol {
    let worker: NetworkWorkerProtocol
    
    init(worker: NetworkWorkerProtocol) {
        self.worker = worker
    }
    
    func getTrendingMovies(completionHandler: @escaping (Result<TrendMoviesResponseModel, APIError>) -> Void) {
        worker.performRequest(
            endpoint: .trendMoviesEndpoint,
            apiMethod: .get,
            responseType: TrendMoviesResponseModel.self,
            completionHandler: completionHandler
        )
    }
    
    func getMoviesDetails(movieId: Int, completionHandler: @escaping (Result<MoviesDetailsModel, APIError>) -> Void) {
        worker.performRequest(
            endpoint: .movieDetailsEndpoint,
            apiMethod: .get,
            responseType: MoviesDetailsModel.self,
            completionHandler: completionHandler
        )
    }
    
    func getMoviesGenres(url: URLComponents?, completionHandler: @escaping (Result<MovieGenresResponseModel, APIError>) -> Void) {
        guard let url = url else {
            completionHandler(Result.failure(APIError.badURL))
            return
        }
        
        let headers = [
            "accept": "application/json",
            "Authorization": "\(Constants.apiKey)"
        ]
        
        var request = URLRequest(
            url: url.url!,
            cachePolicy: .reloadIgnoringLocalCacheData
        )
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error as? URLError {
                completionHandler(Result.failure(APIError.url(error)))
            } else if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                completionHandler(Result.failure(APIError.badResponse(statusCode: httpResponse.statusCode)))
            } else if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let response = try decoder.decode(MovieGenresResponseModel.self, from: data)
                    completionHandler(Result.success(response))
                } catch {
                    completionHandler(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }
        task.resume()
    }
    
}
