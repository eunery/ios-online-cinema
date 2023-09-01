//
//  CoreDataManager.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 28.08.2023.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    
    // MARK: - Properties
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavouriteMoviesData")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    let converter = Converter()
    
    // MARK: - Private properties
    
    private var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // MARK: - Methods
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    public func createMovie(model: FavouriteMovieDB, predicates: NSCompoundPredicate) {
        context.performAndWait {
            if getMovieById(predicates: predicates) != nil {
                print("Dublicate found")
                return
            }
            guard let movieEntityDescription = NSEntityDescription.entity(
                forEntityName: "FavouriteMovieMO",
                in: context) else { return }
            _ = converter.mapToMO(model: model, entity: movieEntityDescription, context: context)
            
            saveContext()
        }
    }
    
    public func getAllMovies() -> [FavouriteMovieDB] {
        context.performAndWait {
            do {
                let movie = (try? context.fetch(FavouriteMovieMO.fetchRequest()) as? [FavouriteMovieMO]) ?? []
                let result = converter.mapToArrayDB(model: movie)
                return result
            }
        }
    }
    
    public func getMovieById(predicates: NSCompoundPredicate) -> FavouriteMovieDB? {
        context.performAndWait {
            let fetchRequest = FavouriteMovieMO.fetchRequest()
            fetchRequest.predicate = predicates
            do {
                guard let movies = try? context.fetch(fetchRequest) as [FavouriteMovieMO],
                      let movie = movies.first else { return nil }
                return converter.mapToDB(model: movie)
            }
        }
    }
    
    public func deleteAllMovies() {
        context.performAndWait {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavouriteMovieMO")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try context.execute(deleteRequest)
            } catch {
                print(error)
            }
            saveContext()
        }
    }
    
    public func deleteMovieById(predicates: NSCompoundPredicate) {
        context.performAndWait {
            let fetchRequest = FavouriteMovieMO.fetchRequest()
            fetchRequest.predicate = predicates
            do {
                guard let movies = try? context.fetch(fetchRequest) as [FavouriteMovieMO],
                      let movie = movies.first else { return }
                context.delete(movie)
            }
            saveContext()
        }
    }
    
    public func isMovieExist(predicates: NSCompoundPredicate) -> Bool {
        context.performAndWait {
            let fetchRequest = FavouriteMovieMO.fetchRequest()
            fetchRequest.predicate = predicates
            do {
                guard let movies = try? context.fetch(fetchRequest) as [FavouriteMovieMO] else { return false }
                if movies.first != nil {
                    return true
                } else {
                    return false
                }
            }
        }
    }
}
