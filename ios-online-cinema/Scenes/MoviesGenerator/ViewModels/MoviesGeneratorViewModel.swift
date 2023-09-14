//
//  MoviesGeneratorViewModel.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 08.09.2023.
//

import Foundation

class MoviesGeneratorViewModel: MoviesGeneratorViewModelProtocol {
    
    // MARK: - Properties
    
    var yearsArray: [Int] = Array(1900...Calendar.current.component(.year, from: .now))
    let apiService = APIService(worker: NetworkWorker())
    var response: MoviesGeneratorResponseModel?
    var genresNames: [Int: String] = [Int: String]()
    
    // MARK: - Methods
    
    func start(completionHandler: @escaping (Result<Void, APIError>) -> Void) {
        self.apiService.getMoviesGenres { result in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                switch result {
                case .failure(let error):
                    completionHandler(.failure(error))
                case .success(let response):
                    for item in response.genres {
                        self.genresNames[item.id] = item.name
                    }
                    completionHandler(.success(()))
                }
            }
        }
    }
    
    func fetch(genre: String, year: Int, completionHandler: @escaping (Result<Void, APIError>) -> Void) {
        let page = Int.random(in: 1...500)
        self.apiService.getGeneratingMovies(page: page,
                                           year: year,
                                           genre: genre) { result in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                switch result {
                case .failure(let error):
                    completionHandler(.failure(error))
                case .success(let response):
                    self.response = response
                    completionHandler(.success(()))
                }
            }
        }
    }
}
