//
//  APIService.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 04.08.2023.
//

import Foundation

struct APIService: APIServiceProtocol {
    
    let worker: NetworkWorkerProtocol
    
    func getTrendingMovies(page: Int?,
                           completionHandler: @escaping (Result<TrendMoviesResponseModel, APIError>) -> Void) {
        var params: [URLQueryItem] = []
        if page != nil {
            params.append(URLQueryItem(name: "page", value: page?.description))
        }
        worker.performRequest(
            queryParametres: params,
            endpoint: Endpoints.trendMovies.rawValue,
            apiMethod: .get,
            responseType: TrendMoviesResponseModel.self,
            completionHandler: completionHandler
        )
    }
    
    func getMoviesDetails(movieId: Int,
                          completionHandler: @escaping (Result<MoviesDetailsResponseModel, APIError>) -> Void) {
        worker.performRequest(
            queryParametres: nil,
            endpoint: Endpoints.movieDetails.rawValue + movieId.description,
            apiMethod: .get,
            responseType: MoviesDetailsResponseModel.self,
            completionHandler: completionHandler
        )
    }
    
    func getMoviesGenres(completionHandler: @escaping (Result<MovieGenresResponseModel, APIError>) -> Void) {
        worker.performRequest(
            queryParametres: nil,
            endpoint: Endpoints.moviesGenres.rawValue,
            apiMethod: .get,
            responseType: MovieGenresResponseModel.self,
            completionHandler: completionHandler
        )
    }
}
