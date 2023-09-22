//
//  CoreDataRepository.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 01.09.2023.
//

import Foundation

class FavouriteMovieDataRepository {
    
    // MARK: - Methods
    
    func createMovie(model: FavouriteMovieDB) {
        let idKeyPredicate =  NSPredicate(format: "id == %@", "\(model.id)")
        let predicates = NSCompoundPredicate(type: .and, subpredicates: [idKeyPredicate])
        if CoreDataManager.shared.getMovieById(predicates: predicates) != nil {
            print("Dublicate found")
            return
        }
        CoreDataManager.shared.createMovie(model: model)
    }
    
    func getAllMovies() -> [FavouriteMovieDB] {
        return CoreDataManager.shared.getAllMovies()
    }
    
    func getMovieById(id: Int) -> FavouriteMovieDB? {
        let idKeyPredicate =  NSPredicate(format: "id == %@", "\(id)")
        let predicates = NSCompoundPredicate(type: .and, subpredicates: [idKeyPredicate])
        return CoreDataManager.shared.getMovieById(predicates: predicates)
    }
    
    func deleteAllMovies() {
        CoreDataManager.shared.deleteAllMovies()
    }
    
    func deleteMovieById(id: Int) {
        let idKeyPredicate =  NSPredicate(format: "id == %@", "\(id)")
        let predicates = NSCompoundPredicate(type: .and, subpredicates: [idKeyPredicate])
        CoreDataManager.shared.deleteMovieById(predicates: predicates)
    }
    
    func isMovieExist(id: Int) -> Bool {
        let idKeyPredicate =  NSPredicate(format: "id == %@", "\(id)")
        let predicates = NSCompoundPredicate(type: .and, subpredicates: [idKeyPredicate])
        return CoreDataManager.shared.isMovieExist(predicates: predicates)
    }
}
