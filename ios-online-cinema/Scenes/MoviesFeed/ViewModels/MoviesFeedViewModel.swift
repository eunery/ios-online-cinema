//
//  MoviesFeedViewModel.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 01.08.2023.
//

import Foundation

class MoviesFeedViewModel: MoviesFeedViewModelProtocol {
    
    // MARK: - Properties
    
    var genres: [Int: String] = [Int: String]()
    let apiService = APIService(worker: NetworkWorker())
    var dataSource = [MovieCollectionViewCellModel]()
    var currentPage = 1
    var totalPages = 1
    let host = "image.tmdb.org"
    let scheme = "https"
    let path = "/t/p/w500"

    // MARK: - Methods
    
    func start(completionHandler: @escaping (Result<Void, APIError>) -> Void) {
        getGenresAndMovies { result in
            completionHandler(result)
        }
    }
    
    func fetch(page: Int?, completionHandler: @escaping (Result<Void, APIError>) -> Void) {
        getMovies(page: page) { result in
            completionHandler(result)
        }
    }
    
    func getGenresAndMovies(completionHandler: @escaping (Result<Void, APIError>) -> Void) {
        self.apiService.getMoviesGenres { result in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                switch result {
                case .failure(let error):
                    completionHandler(.failure(error))
                case .success(let response):
                    for item in response.genres {
                        self.genres[item.id] = item.name
                    }
                    self.getMovies(page: nil) { _ in
                        completionHandler(.success(()))
                    }
                }
            }
        }
    }
    
    func getMovies(page: Int?, completionHandler: @escaping (Result<Void, APIError>) -> Void) {
        self.apiService.getTrendingMovies(page: page) { result in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                switch result {
                case .failure(let error):
                    completionHandler(.failure(error))
                case .success(let response):
                    self.currentPage = response.page
                    self.totalPages = response.totalPages
                    self.setupDataSource(response: response) { result in
                        completionHandler(result)
                    }
                }
            }
        }
    }
    
    func setupDataSource(
        response: TrendMoviesResponseModel,
        completionHandler: @escaping (Result<Void, APIError>) -> Void) {
        var url = URLComponents()
        url.scheme = self.scheme
        url.host = self.host
        self.dataSource += response.results.map {
            var genresString: [String] = [String]()
            url.path = self.path + $0.posterPath
            for item in $0.genreIds {
                genresString.append(self.genres[item] ?? "")
            }
            return MovieCollectionViewCellModel(
                id: $0.id,
                poster: url.description,
                title: $0.title,
                genre: genresString.formatted()
            )
        }
        completionHandler(.success(()))
    }
    
    func validatePage(indexPath: IndexPath) -> Bool {
        if indexPath.item == self.dataSource.count - 1, self.currentPage < self.totalPages {
            self.currentPage += 1
            return true
        } else {
            return false
        }
    }
}
