//
//  APIService.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 04.08.2023.
//

import Foundation

protocol APIServiceProtocol {
    func getTrendingMovies(url: URLComponents?, completionHandler: @escaping (Result<TrendMoviesResponseModel, APIError>) -> Void)
    func getMoviesDetails(movieId: Int, url: URLComponents?, completionHandler: @escaping (Result<MoviesDetailsModel, APIError>) -> Void)
}

struct APIService: APIServiceProtocol {
    let token = APIKeys()
    let decoder = JSONDecoder()
    let scheme = "https"
    let host = "api.themoviedb.org"
    let trendMoviesEndpoint = "/3/trending/movie/day"
    let movieDetailsEndpoint = "/3/trending/movie/day"
//    var urlTrends = URLComponents(string: "https://api.themoviedb.org/3/trending/movie/day")
//    var urlDetails = URLComponents(string: "https://api.themoviedb.org/3/movie/")
    
    func getTrendingMovies(url: URLComponents?, completionHandler: @escaping (Result<TrendMoviesResponseModel, APIError>) -> Void) {
        var url = URLComponents()
        url.scheme = scheme
        url.host = host
        url.path = trendMoviesEndpoint
        
        let headers = [
            "accept": "application/json",
            "Authorization": "\(token.token)"
        ]
        
        var request = URLRequest(
            url: url.url!,
            cachePolicy: .reloadIgnoringLocalCacheData
        )
        request.httpMethod = APIMethods.get.type()
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error as? URLError {
                completionHandler(Result.failure(APIError.url(error)))
            } else if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                completionHandler(Result.failure(APIError.badResponse(statusCode: httpResponse.statusCode)))
            } else if let data = data {
                do {
                    let response = try decoder.decode(TrendMoviesResponseModel.self, from: data)
                    completionHandler(Result.success(response))
                } catch {
                    completionHandler(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }
        task.resume()
    }
    
    func getMoviesDetails(movieId: Int, url: URLComponents?, completionHandler: @escaping (Result<MoviesDetailsModel, APIError>) -> Void) {
        guard var url = url else {
            completionHandler(Result.failure(APIError.badURL))
            return
        }
        
        let headers = [
            "accept": "application/json",
            "Authorization": "\(token.token)"
        ]
        
        url.path.append("\(movieId)")
        
        var request = URLRequest(
            url: url.url!,
            cachePolicy: .reloadIgnoringLocalCacheData
        )
        request.httpMethod = APIMethods.get.type()
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error as? URLError {
                completionHandler(Result.failure(APIError.url(error)))
            } else if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                completionHandler(Result.failure(APIError.badResponse(statusCode: httpResponse.statusCode)))
            } else if let data = data {
                do {
                    let response = try decoder.decode(MoviesDetailsModel.self, from: data)
                    completionHandler(Result.success(response))
                } catch {
                    completionHandler(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }
        task.resume()
    }
    
}
