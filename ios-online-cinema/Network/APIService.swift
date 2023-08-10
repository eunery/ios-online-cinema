//
//  APIService.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 04.08.2023.
//

import Foundation

struct APIService: APIServiceProtocol {
    let worker = NetworkWorker()
    
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
    
}
