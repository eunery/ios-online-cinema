//
//  MoviesDetailsViewModel.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 01.08.2023.
//

import Foundation

class MoviesDetailsViewModel: MoviesDetailsViewModelProtocol {
    
    // MARK: - Properties
    
    var error: String?
    var movie: MoviesDetailsModel?
    var movieId: Int
    let service = APIService(worker: NetworkWorker())
    var dataSource: MovieDetailsTableViewCellModel?
    
    // MARK: - Init
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    // MARK: - Methods
    
    func fetch(movieId: Int, completionHandler: @escaping (Result<Void, APIError>) -> Void) {
        service.getMoviesDetails(movieId: movieId) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .failure(let error):
                    self?.error = error.localizedDescription
                    completionHandler(Result.failure(error))
                case .success(let response):
                    self?.movie = response
                }
                self?.setupDataSource { result in
                    completionHandler(result)
                }
            }
        }
    }
    
    func setupDataSource(completionHandler: @escaping (Result<Void, APIError>) -> Void) {
        guard let movie = self.movie else { return }
        var tempArray = movie.genres.map {
            $0.name
        }
        self.dataSource = MovieDetailsTableViewCellModel(
            id: movie.id,
            poster: movie.posterPath,
            genre: tempArray.formatted(),
            vote: movie.voteAverage.description,
            releaseDate: String(movie.releaseDate.prefix(4)),
            title: movie.title,
            overview: movie.overview
        )
        completionHandler(Result.success(()))
    }
}
