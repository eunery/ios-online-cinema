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
    func getMoviesGenres(url: URLComponents?, completionHandler: @escaping (Result<MovieGenresResponseModel, APIError>) -> Void)
}

struct APIService: APIServiceProtocol {
    
    private let token = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4NzljMGMyNzllODJiZjQ3NDY2ZTU4NjcwNDRkNjJlNiIsInN1YiI6IjY0YzhiZjBiZjc5NGFkMDBlMjZjODk4ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.TX6MXCYPqauaAqZrXR2YLESOlkobEcz80IwZWFmTM1I"
    var urlGenres = URLComponents(string: "https://api.themoviedb.org/3/genre/movie/list")
    var urlTrends = URLComponents(string: "https://api.themoviedb.org/3/trending/movie/day")
    var urlDetails = URLComponents(string: "https://api.themoviedb.org/3/movie/")
    
    func getTrendingMovies(url: URLComponents?, completionHandler: @escaping (Result<TrendMoviesResponseModel, APIError>) -> Void) {
        guard let url = url else {
            completionHandler(Result.failure(APIError.badURL))
            return
        }
        
        let headers = [
            "accept": "application/json",
            "Authorization": "\(token)"
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
            "Authorization": "\(token)"
        ]
        
        url.path.append("\(movieId)")
        
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
                    let response = try decoder.decode(MoviesDetailsModel.self, from: data)
                    completionHandler(Result.success(response))
                } catch {
                    completionHandler(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }
        task.resume()
    }
    
    func getMoviesGenres(url: URLComponents?, completionHandler: @escaping (Result<MovieGenresResponseModel, APIError>) -> Void) {
        guard let url = url else {
            completionHandler(Result.failure(APIError.badURL))
            return
        }
        
        let headers = [
            "accept": "application/json",
            "Authorization": "\(token)"
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
