//
//  Converter.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 01.09.2023.
//

import Foundation
import CoreData

class FavouriteMoviesConverter {
    
    // MARK: - Methods
    
    func mapToDB(model: FavouriteMovieMO) -> FavouriteMovieDB {
        return FavouriteMovieDB(id: model.id,
                                poster: model.poster,
                                genres: model.genres,
                                vote: model.vote,
                                releaseDate: model.releaseDate,
                                title: model.title,
                                overview: model.overview
        )
    }
    
    func mapToArrayDB(model: [FavouriteMovieMO]) -> [FavouriteMovieDB] {
        return model.map {
            FavouriteMovieDB(id: $0.id,
                             poster: $0.poster,
                             genres: $0.genres,
                             vote: $0.vote,
                             releaseDate: $0.releaseDate,
                             title: $0.title,
                             overview: $0.overview
            )
        }
    }
    
    func mapToMO(model: FavouriteMovieDB,
                 entity: NSEntityDescription,
                 context: NSManagedObjectContext) -> FavouriteMovieMO {
        let movie = FavouriteMovieMO(entity: entity, insertInto: context)
        movie.id = model.id
        movie.poster = model.poster
        movie.genres = model.genres
        movie.vote = model.vote
        movie.releaseDate = model.releaseDate
        movie.title = model.title
        movie.overview = model.overview
        
        return movie
    }
}
