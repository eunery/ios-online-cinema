//
//  FavouriteMoviesViewModelProtocol.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 10.08.2023.
//

import Foundation

protocol FavouriteMoviesViewModelProtocol {
    
    var dataSource: [Movie] { get set }
    
    func fetch(completionHandler: () -> Void)
    func deleteMovie(id: Int, completionHandler: () -> Void)
}
