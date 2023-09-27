//
//  APIServiceProtocol.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 10.08.2023.
//

import Foundation

protocol APIServiceProtocol {
    
    func getTrendingMovies(page: Int?,
                           completionHandler: @escaping (Result<TrendMoviesResponseModel, APIError>) -> Void)
    func getMoviesDetails(movieId: Int,
                          completionHandler: @escaping (Result<MoviesDetailsResponseModel, APIError>) -> Void)
    func getMoviesGenres(completionHandler: @escaping (Result<MovieGenresResponseModel, APIError>) -> Void)
    func getGeneratingMovies(page: String,
                             year: String,
                             genre: String,
                             completionHandler: @escaping (Result<MoviesGeneratorResponseModel, APIError>) -> Void)
}
