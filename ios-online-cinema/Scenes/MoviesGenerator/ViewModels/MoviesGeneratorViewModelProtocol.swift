//
//  MoviesGeneratorViewModelProtocol.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 08.09.2023.
//

import Foundation

protocol MoviesGeneratorViewModelProtocol {
    var yearsArray: [Int] { get }
    var genresNames: [String] { get set }
    var generatedMovieId: Int? { get set }
    var genre: String? { get set }
    var year: String? { get set }
    var isLoading: Bool { get set }
    
    func start(completionHandler: @escaping (Result<Void, APIError>) -> Void)
    func fetch(genre: String, year: String, completionHandler: @escaping (Result<Void, APIError>) -> Void)
    func setGenre(genre: String)
    func setYear(year: String)
    func validateFields() -> Bool
    func setLoaderState(state: Bool)
}
