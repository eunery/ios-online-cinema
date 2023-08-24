//
//  MoviesDetailsViewModel.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 01.08.2023.
//

import Foundation

class MoviesDetailsViewModel: MoviesDetailsViewModelProtocol {
    
    // MARK: - Properties
    
    let movieId: Int
    let apiService = APIService(worker: NetworkWorker())
    var dataSource: MovieDetailsTableViewCellModel?
    
    // MARK: - Init
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    // MARK: - Methods
    
    func fetch(completionHandler: @escaping (Result<Void, APIError>) -> Void) {
        apiService.getMoviesDetails(movieId: self.movieId) { result in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                switch result {
                case .failure(let error):
                    completionHandler(.failure(error))
                case .success(let response):
                    self.setupDataSource(response: response) { result in
                        completionHandler(result)
                    }
                }
            }
        }
    }
    
    func setupDataSource(response: MoviesDetailsModel, completionHandler: @escaping (Result<Void, APIError>) -> Void) {
        let host = "image.tmdb.org"
        let scheme = "https"
        let path = "/t/p/w500"
        var url = URLComponents()
        url.scheme = scheme
        url.host = host
        url.path = path + response.posterPath
        let genresNamesArray = response.genres.map {
            $0.name
        }
        self.dataSource = MovieDetailsTableViewCellModel(
            id: response.id,
            poster: url.description,
            genre: genresNamesArray.formatted(),
            vote: response.voteAverage.description,
            releaseDate: String(response.releaseDate.prefix(4)),
            title: response.title,
            overview: response.overview
        )
        completionHandler(.success(()))
    }
}
