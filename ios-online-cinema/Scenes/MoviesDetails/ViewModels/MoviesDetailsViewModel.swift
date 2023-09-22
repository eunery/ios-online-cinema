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
    let coreDataRepository = FavouriteMovieDataRepository()
    let converter = MoviesDetailsConverter()
    
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
        let url = converter.createImageURL(posterPath: response.posterPath)

        self.dataSource.append(MoviesDetailsPosterCellData(poster: url.description))
        
        self.dataSource.append(MoviesDetailsInfoCellData(
            genres: converter.formatGenresNames(genres: response.genres),
            vote: response.voteAverage.description,
            date: String(response.releaseDate.prefix(4)),
            isFavourite: isMovieFavourite()
        ))
        
        self.dataSource.append(MoviesDetailsOverviewCellData(
            title: response.title,
            overview: response.overview
        ))
        
        completionHandler(.success(()))
    }
    
    func addToFavourites() throws {
        guard let response = self.response else {
            throw APIError.emptyResponse
        }
        let dbModel = converter.mapToDB(response: response)
        coreDataRepository.createMovie(model: dbModel)
        var index = 0
        for source in self.dataSource {
            switch source.type {
            case .poster: break
            case .info:
                guard var source = source as? MoviesDetailsInfoCellData else { return }
                source.isFavourite = true
                self.dataSource[index] = source
            case .overview: break
            }
            index += 1
        }
    }
    
    func deleteFromFavoruites() {
        guard let response else { return }
        var index = 0
        for source in self.dataSource {
            switch source.type {
            case .poster: break
            case .info:
                guard var source = source as? MoviesDetailsInfoCellData else { return }
                source.isFavourite = false
                self.dataSource[index] = source
            case .overview: break
            }
            index += 1
        }
        coreDataRepository.deleteMovieById(id: response.id)
    }
    
    func isMovieFavourite() -> Bool {
        guard let response else { return false }
        return coreDataRepository.isMovieExist(id: response.id)
    }
}
