//
//  MoviesGeneratorViewModel.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 08.09.2023.
//

import Foundation
import Resolver

class MoviesGeneratorViewModel: MoviesGeneratorViewModelProtocol {
    
    // MARK: - Properties
    
    var yearsArray: [Int] = Array(1900...Calendar.current.component(.year, from: .now))
    @Injected var apiService: APIServiceProtocol
    var generatedMovieId: Int?
    var genresNames: [String] = [String]()
    var selectedGenre: String?
    var selectedYear: String?
    
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
    
    func fetch(completionHandler: @escaping (Result<Void, Error>) -> Void) {
        let page = Int.random(in: 1...500)
        guard let genre = self.selectedGenre else { return }
        guard let year = self.selectedYear else { return }
        self.apiService.getGeneratingMovies(page: page.description,
                                            year: year,
                                            genre: genre) { result in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                switch result {
                case .failure(let error):
                    completionHandler(.failure(error))
                case .success(let response):
                    if response.results.count == 0 {
                        completionHandler(.failure(MoviesGeneratorError.generationError))
                    }
                    self.generatedMovieId = response.results.randomElement()?.id
                    completionHandler(.success(()))
                }
            }
        }
    }
    
    func setGenre(genre: String) {
        self.selectedGenre = genre
    }
    
    func setYear(year: String) {
        self.selectedYear = year
    }
    
    func validateFields() -> Bool {
        guard let selectedGenre, let selectedYear else { return false }
        return !(selectedGenre.isEmpty) && !(selectedYear.isEmpty) ? true : false
    }
}
