//
//  CoreDataRepository.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 01.09.2023.
//

import Foundation
import Resolver

class FavouriteMovieDataRepository {
    
    // MARK: - Properties
    
    @Injected var coreDataManager: CoreDataManager
    
    // MARK: - Methods
    
    func createMovie(model: FavouriteMovieDB) {
        let idKeyPredicate =  NSPredicate(format: "id == %@", "\(model.id)")
        let predicates = NSCompoundPredicate(type: .and, subpredicates: [idKeyPredicate])
        if coreDataManager.getMovieById(predicates: predicates) != nil {
            print("Dublicate found")
            return
        }
        coreDataManager.createMovie(model: model)
    }
    
    func getAllMovies() -> [FavouriteMovieDB] {
        return coreDataManager.getAllMovies()
    }
    
    func getMovieById(id: Int) -> FavouriteMovieDB? {
        let idKeyPredicate =  NSPredicate(format: "id == %@", "\(id)")
        let predicates = NSCompoundPredicate(type: .and, subpredicates: [idKeyPredicate])
        return coreDataManager.getMovieById(predicates: predicates)
    }
    
    func deleteAllMovies() {
        coreDataManager.deleteAllMovies()
    }
    
    func deleteMovieById(id: Int) {
        let idKeyPredicate =  NSPredicate(format: "id == %@", "\(id)")
        let predicates = NSCompoundPredicate(type: .and, subpredicates: [idKeyPredicate])
        coreDataManager.deleteMovieById(predicates: predicates)
    }
    
    func isMovieExist(id: Int) -> Bool {
        let idKeyPredicate =  NSPredicate(format: "id == %@", "\(id)")
        let predicates = NSCompoundPredicate(type: .and, subpredicates: [idKeyPredicate])
        return coreDataManager.isMovieExist(predicates: predicates)
    }
}
