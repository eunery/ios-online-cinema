//
//  FavouriteMoviesViewModel.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 01.08.2023.
//

import Foundation

class FavouriteMoviesViewModel: FavouriteMoviesViewModelProtocol {
    
    var dataSource = [Movie]()
    
    func fetch(completionHandler: () -> Void) {
        self.dataSource = CoreDataManager.shared.getAllMovies()
        completionHandler()
    }
    
    func deleteMovie(id: Int, completionHandler: () -> Void) {
        CoreDataManager.shared.deleteMovieById(id: id)
        fetch { }
        completionHandler()
    }
}
