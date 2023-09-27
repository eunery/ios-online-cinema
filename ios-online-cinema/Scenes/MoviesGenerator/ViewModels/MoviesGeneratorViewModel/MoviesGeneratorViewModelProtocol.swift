//
//  MoviesGeneratorViewModelProtocol.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 08.09.2023.
//

import Foundation

protocol MoviesGeneratorViewModelProtocol {
    var yearsArray: [Int] { get }
    var genresNames: [String] { get }
    var generatedMovieId: Int? { get }
    
    func start(completionHandler: @escaping (Result<Void, APIError>) -> Void)
    func fetch(completionHandler: @escaping (Result<Void, Error>) -> Void)
    func setGenre(genre: String)
    func setYear(year: String)
    func validateFields() -> Bool
}
