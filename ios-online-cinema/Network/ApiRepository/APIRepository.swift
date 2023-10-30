//
//  APIRepository.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 25.10.2023.
//

import Foundation
import Resolver

class APIRepository: APIRepositoryProtocol {
    
    // MARK: - Properties
    
    @Injected var apiService: APIServiceProtocol
    
    // MARK: - Methods
    
    func getTrendingMovies(
        page: Int?,
        completionHandler: @escaping (Result<TrendMoviesResponseModel, APIError>) -> Void) {
        apiService.getTrendingMovies(page: page) { result in
            completionHandler(result)
        }
    }
    
    func getMoviesDetails(
        movieId: Int,
        completionHandler: @escaping (Result<MoviesDetailsResponseModel, APIError>) -> Void) {
        apiService.getMoviesDetails(movieId: movieId) { result in
            completionHandler(result)
        }
    }
    
    func getMoviesGenres(
        completionHandler: @escaping (Result<MovieGenresResponseModel, APIError>) -> Void) {
        apiService.getMoviesGenres { result in
            completionHandler(result)
        }
    }
    
    func getGeneratingMovies(
        page: String,
        year: String,
        genre: String,
        completionHandler: @escaping (Result<MoviesGeneratorResponseModel, APIError>) -> Void) {
        apiService.getGeneratingMovies(
            page: page,
            year: year,
            genre: genre) { result in
            completionHandler(result)
        }
    }
}
