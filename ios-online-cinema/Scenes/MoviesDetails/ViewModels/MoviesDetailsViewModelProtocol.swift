//
//  MoviesDetailsViewModelProtocol.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 10.08.2023.
//

import Foundation

protocol MoviesDetailsViewModelProtocol {
    var dataSource: [MoviesDetailsCellDataProtocol] { get set }
    
    func fetch(completionHandler: @escaping (Result<Void, APIError>) -> Void)
    func addToFavourites() throws
    func deleteFromFavoruites()
    func isMovieFavourite() -> Bool
}
