//
//  MoviesFeedConverter.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 19.10.2023.
//

import Foundation

class MoviesFeedConverter {
    
    // MARK: - Methods
    
    func fromResponseToGenres(response: MovieGenresResponseModel) -> [Int: String] {
        var genres: [Int: String] = [Int: String]()
        for item in response.genres {
            genres[item.id] = item.name
        }
        return genres
    }
    
    func fromResponseToDataSource(
        id: Int, poster: String, title: String, genre: String) -> MovieCollectionViewCellModel {
        return MovieCollectionViewCellModel(
            id: id,
            poster: poster,
            title: title,
            genre: genre
        )
    }
}
