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
    
    public static let shared = CoreDataManager()
    
    // MARK: - Private properties
    
    private let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
    
    private var appDelegate: AppDelegate {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
                fatalError("could not get app delegate ")
        }
        return delegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    private let host = "image.tmdb.org"
    private let scheme = "https"
    private let path = "/t/p/w500"
    
    // MARK: - Init
    
    private override init() {}
    
    // MARK: - Methods
    
    public func createMovie(id: Int,
                            poster: String,
                            genres: String,
                            vote: String,
                            releaseDate: String,
                            title: String,
                            overview: String) {
        if getMovieById(id: id) != nil {
            return
        }
        guard let movieEntityDescription = NSEntityDescription.entity(
            forEntityName: "Movie",
            in: context) else { return }
        let movie = Movie(entity: movieEntityDescription, insertInto: context)
        var url = URLComponents()
        url.scheme = scheme
        url.host = host
        url.path = path + poster
        movie.id = id
        movie.poster = url.description
        movie.genres = genres
        movie.vote = vote
        movie.releaseDate = releaseDate
        movie.title = title
        movie.overview = overview
        
        appDelegate.saveContext()
    }
    
    public func getAllMovies() -> [Movie] {
        do {
            return (try? context.fetch(self.request) as? [Movie]) ?? []
        }
    }
    
    public func getMovieById(id: Int) -> Movie? {
        do {
            guard let movies = try? context.fetch(self.request) as? [Movie] else { return nil }
            return movies.first(where: { $0.id == id })
        }
    }
    
    public func deleteAllMovies() {
        do {
            guard let movies = try? context.fetch(self.request) as? [Movie] else { return }
            movies.forEach({ context.delete($0) })
        }
        appDelegate.saveContext()
    }
    
    public func deleteMovieById(id: Int) {
        self.request.predicate = NSPredicate(format: "id == %@", "\(id)")
        do {
            guard let movies = try? context.fetch(self.request) as? [Movie],
                  let movie = movies.first else { return }
            context.delete(movie)
        }
        appDelegate.saveContext()
    }
    
    public func isMovieExist(id: Int) -> Bool {
        do {
            guard let movies = try? context.fetch(self.request) as? [Movie] else { return false }
            return movies.contains(where: { $0.id == id })
        }
    }
}
