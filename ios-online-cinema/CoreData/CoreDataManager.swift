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
    let converter = FavouriteMoviesConverter()
    
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
            }
        }
    }
    
    public func createMovie(model: FavouriteMovieDB) {
        context.performAndWait {
            guard let movieEntityDescription = NSEntityDescription.entity(
                forEntityName: FavouriteMovieMO.identifier,
                in: context) else { return }
            _ = converter.mapToMO(model: model, entity: movieEntityDescription, context: context)
            
            saveContext()
        }
    }
    
    public func getAllMovies() -> [FavouriteMovieDB] {
        context.performAndWait {
            do {
                let movie = (try context.fetch(FavouriteMovieMO.fetchRequest()) as? [FavouriteMovieMO]) ?? []
                let result = converter.mapToArrayDB(model: movie)
                return result
            } catch {
                print(error)
                return []
            }
        }
    }
    
    public func getMovieById(predicates: NSPredicate) -> FavouriteMovieDB? {
        context.performAndWait {
            let fetchRequest = FavouriteMovieMO.fetchRequest()
            fetchRequest.predicate = predicates
            do {
                let movies = try context.fetch(fetchRequest) as [FavouriteMovieMO]
                guard let movie = movies.first else { return nil }
                return converter.mapToDB(model: movie)
            } catch {
                print(error)
                return nil
            }
        }
    }
    
    public func deleteAllMovies() {
        context.performAndWait {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(
                entityName: FavouriteMovieMO.identifier)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try context.execute(deleteRequest)
            } catch {
                print(error)
            }
            saveContext()
        }
    }
    
    public func deleteMovieById(predicates: NSPredicate) {
        context.performAndWait {
            let fetchRequest = FavouriteMovieMO.fetchRequest()
            fetchRequest.predicate = predicates
            do {
                let movies = try context.fetch(fetchRequest) as [FavouriteMovieMO]
                guard let movie = movies.first else { return }
                context.delete(movie)
            } catch {
                print(error)
            }
            
            saveContext()
        }
    }
    
    public func isMovieExist(predicates: NSPredicate) -> Bool {
        context.performAndWait {
            let fetchRequest = FavouriteMovieMO.fetchRequest()
            fetchRequest.predicate = predicates
            do {
                let movies = try context.fetch(fetchRequest) as [FavouriteMovieMO]
                if movies.first != nil {
                    return true
                } else {
                    return false
                }
            } catch {
                print(error)
                return false
            }
        }
    }
}
