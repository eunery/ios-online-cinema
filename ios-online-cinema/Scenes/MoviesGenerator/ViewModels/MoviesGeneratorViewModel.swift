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
    var generatedMovieId: Int?
    var genresNames: [String] = [String]()
    var genre: String?
    var year: String?
    
    // MARK: - Methods
    
    func start(completionHandler: @escaping (Result<Void, APIError>) -> Void) {
        genresNames.removeAll()
        self.apiService.getMoviesGenres { result in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                switch result {
                case .failure(let error):
                    completionHandler(.failure(error))
                case .success(let response):
                    for item in response.genres {
                        self.genresNames.append(item.name)
                    }
                    completionHandler(.success(()))
                }
            }
        }
    }
    
    func fetch(genre: String, year: String, completionHandler: @escaping (Result<Void, APIError>) -> Void) {
        let page = Int.random(in: 1...500)
        self.apiService.getGeneratingMovies(page: page.description,
                                           year: year,
                                           genre: genre) { result in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                switch result {
                case .failure(let error):
                    completionHandler(.failure(error))
                case .success(let response):
                    self.generatedMovieId = response.results.randomElement()?.id
                    completionHandler(.success(()))
                }
            }
        }
    }
    
    func setGenre(genre: String) {
        self.genre = genre
    }
    
    func setYear(year: String) {
        self.year = year
    }
    
    func validateFields() -> Bool {
        guard let genre, let year else { return false }
        return !(genre.isEmpty) && !(year.isEmpty) ? true : false
    }
}
