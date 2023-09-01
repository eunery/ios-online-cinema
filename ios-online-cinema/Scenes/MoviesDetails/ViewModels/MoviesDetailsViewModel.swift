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
    var dataSource = [MoviesDetailsCellDataProtocol]()
    var response: MoviesDetailsResponseModel?
    let host = "image.tmdb.org"
    let scheme = "https"
    let path = "/t/p/w500"
    let coreDataRepository = CoreDataRepository()
    
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
                    self.response = response
                    self.setupDataSource(response: response) { result in
                        completionHandler(result)
                    }
                }
            }
        }
    }
    
    func setupDataSource(response: MoviesDetailsResponseModel,
                         completionHandler: @escaping (Result<Void, APIError>) -> Void) {
        var url = URLComponents()
        url.scheme = scheme
        url.host = host
        url.path = path + response.posterPath
        let genresNamesArray = response.genres.map {
            $0.name
        }
        
        self.dataSource.append(MoviesDetailsPosterCellData(poster: url.description))
        
        self.dataSource.append(MoviesDetailsInfoCellData(
            genres: genresNamesArray.formatted(),
            vote: response.voteAverage.description,
            date: String(response.releaseDate.prefix(4))
        ))
        
        self.dataSource.append(MoviesDetailsOverviewCellData(
            title: response.title,
            overview: response.overview
        ))
        
        completionHandler(.success(()))
    }
    
    func addToFavourites(error: (String) -> Void) {
        guard let response = self.response else {
            error("Response is nil")
            return
        }
        let genresNamesArray = response.genres.map {
            $0.name
        }
        var url = URLComponents()
        url.scheme = scheme
        url.host = host
        url.path = path + response.posterPath
        let dbModel = FavouriteMovieDB(id: response.id,
                                       poster: url.description,
                                       genres: genresNamesArray.formatted(),
                                       vote: response.voteAverage.description,
                                       releaseDate: response.releaseDate,
                                       title: response.title,
                                       overview: response.overview
            )
        coreDataRepository.createMovie(model: dbModel)
        
    }
    
    func deleteFromFavoruites() {
        guard let response else { return }
        coreDataRepository.deleteMovieById(id: response.id)
    }
    
    func isMovieFavourite() -> Bool {
        guard let response else { return false }
        return coreDataRepository.isMovieExist(id: response.id)
    }
}
