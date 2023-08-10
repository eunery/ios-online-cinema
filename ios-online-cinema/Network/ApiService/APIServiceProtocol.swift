//
//  APIServiceProtocol.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 10.08.2023.
//

import Foundation

protocol APIServiceProtocol {
    func getTrendingMovies(completionHandler: @escaping (Result<TrendMoviesResponseModel, APIError>) -> Void)
    func getMoviesDetails(movieId: Int, completionHandler: @escaping (Result<MoviesDetailsModel, APIError>) -> Void)
    func getMoviesGenres(url: URLComponents?, completionHandler: @escaping (Result<MovieGenresResponseModel, APIError>) -> Void)
}
