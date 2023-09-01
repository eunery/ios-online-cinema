//
//  FavouriteMoviesViewModel.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 01.08.2023.
//

import Foundation

class FavouriteMoviesViewModel: FavouriteMoviesViewModelProtocol {
    
    var dataSource = [FavouriteMovieDB]()
    let coreDataRepository = CoreDataRepository()
    
    func fetch() {
        self.dataSource = coreDataRepository.getAllMovies()
    }
    
    func deleteMovie(id: Int) {
        coreDataRepository.deleteMovieById(id: id)
        fetch()
    }
}
