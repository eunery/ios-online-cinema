//
//  APIService.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 04.08.2023.
//

import Foundation

struct APIService: APIServiceProtocol {
    let token = Constants.apiKey
    let decoder = JSONDecoder()
    let scheme = "https"
    let host = "api.themoviedb.org"
    let trendMoviesEndpoint = "/3/trending/movie/day"
    let movieDetailsEndpoint = "/3/movie/"
    
    func loadData<T: Codable>(apiMethod: APIMethods, components: URLComponents?, responseType: T.Type, completionHandler: @escaping(Result<T, APIError>) -> Void) {
        guard let components = components else {
            completionHandler(Result.failure(APIError.badURL))
            return
        }
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
                    let response = try decoder.decode(responseType.self, from: data)
                    completionHandler(Result.success(response))
                } catch {
                    completionHandler(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }
        task.resume()
    }
    
    
    func getTrendingMovies(completionHandler: @escaping (Result<TrendMoviesResponseModel, APIError>) -> Void) {
        var url = URLComponents()
        url.scheme = scheme
        url.host = host
        url.path = trendMoviesEndpoint
        
        loadData(
            apiMethod: .get,
            components: url,
            responseType: TrendMoviesResponseModel.self,
            completionHandler: completionHandler
        )
    }
    
    func getMoviesDetails(movieId: Int, completionHandler: @escaping (Result<MoviesDetailsModel, APIError>) -> Void) {
        var url = URLComponents()
        url.scheme = scheme
        url.host = host
        url.path = movieDetailsEndpoint
        url.path.append("\(movieId)")
        
        loadData(
            apiMethod: .get,
            components: url,
            responseType: MoviesDetailsModel.self,
            completionHandler: completionHandler
        )
    }
    
}
