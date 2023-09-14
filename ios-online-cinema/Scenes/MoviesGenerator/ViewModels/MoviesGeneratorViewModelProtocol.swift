//
//  MoviesGeneratorViewModelProtocol.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 08.09.2023.
//

import Foundation

protocol MoviesGeneratorViewModelProtocol {
    var yearsArray: [Int] { get }
    var response: MoviesGeneratorResponseModel? { get set }
    var genresNames: [Int: String] { get set }
    
    func start(completionHandler: @escaping (Result<Void, APIError>) -> Void)
    func fetch(genre: String, year: Int, completionHandler: @escaping (Result<Void, APIError>) -> Void)
}
