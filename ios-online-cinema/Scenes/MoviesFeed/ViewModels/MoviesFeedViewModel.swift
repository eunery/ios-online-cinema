//
//  MoviesFeedViewModel.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 01.08.2023.
//

import Foundation

class MoviesFeedViewModel: MoviesFeedViewModelProtocol {
    
    // MARK: - Properties
    
    var error: String?
    var genres: [Int: String] = [Int: String]()
    let service = APIService(worker: NetworkWorker())
    var dataSource = [MovieCollectionViewCellModel]()
    var currentPage = 1
    var totalPages = 1

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
        self.service.getMoviesGenres { result in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                switch result {
                case .failure(let error):
                    self.error = error.localizedDescription
                    completionHandler(Result.failure(error))
                case .success(let response):
                    for item in response.genres {
                        self.genres[item.id] = item.name
                    }
                    self.getMovies(page: nil) { _ in
                        completionHandler(Result.success(()))
                    }
                }
            }
        }
    }
    
    func getMovies(page: Int?, completionHandler: @escaping (Result<Void, APIError>) -> Void) {
        self.service.getTrendingMovies(page: page) { result in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                switch result {
                case .failure(let error):
                    self.error = error.localizedDescription
                    print(error)
                    completionHandler(Result.failure(error))
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
        let host = "image.tmdb.org"
        let scheme = "https"
        let path = "/t/p/w500"
        var url = URLComponents()
        url.scheme = scheme
        url.host = host
        var genresString: [String] = [String]()
        var tempArray = response.results.map {
            url.path = path + $0.posterPath
            genresString.removeAll()
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
        for item in tempArray {
            self.dataSource.append(item)
        }
        tempArray.removeAll()
        completionHandler(Result.success(()))
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
