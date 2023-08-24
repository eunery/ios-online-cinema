//
//  APIServiceProtocol.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 10.08.2023.
//

import Foundation

protocol APIServiceProtocol {
    
    func getTrendingMovies(
        page: Int?,
        completionHandler: @escaping (Result<TrendMoviesResponseModel, APIError>) -> Void)
    func getMoviesDetails(
        movieId: Int,
        completionHandler: @escaping (Result<MoviesDetailsModel, APIError>) -> Void)
    func getMoviesGenres(completionHandler: @escaping (Result<MovieGenresResponseModel, APIError>) -> Void)
}
