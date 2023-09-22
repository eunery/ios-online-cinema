//
//  FavouriteMoviesViewModelProtocol.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 10.08.2023.
//

import Foundation

protocol FavouriteMoviesViewModelProtocol {
    
    var dataSource: [FavouriteMovieDB] { get set }
    
    func fetch()
    func deleteMovie(id: Int)
}
