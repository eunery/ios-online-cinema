//
//  MoviesDetailsConverter.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 06.09.2023.
//

import Foundation

class MoviesDetailsConverter {
    
    // MARK: - Properties
    
    let host = "image.tmdb.org"
    let scheme = "https"
    let path = "/t/p/w500"
    
    // MARK: - Methods
    
    func mapToDB(response: MoviesDetailsResponseModel) -> FavouriteMovieDB {
        let url = createImageURL(posterPath: response.posterPath ?? "")
        return FavouriteMovieDB(id: response.id,
                                poster: url.description,
                                genres: formatGenresNames(genres: response.genres),
                                vote: response.voteAverage.description,
                                releaseDate: String(response.releaseDate.prefix(4)),
                                title: response.title,
                                overview: response.overview
        )
    }
    
    func createImageURL(posterPath: String) -> URLComponents {
        var url = URLComponents()
        url.scheme = self.scheme
        url.host = self.host
        url.path = self.path + posterPath
        return url
    }
    
    func formatGenresNames(genres: [GenreIdModel]) -> String {
        let genresNamesArray = genres.map {
            $0.name
        }
        return genresNamesArray.formatted()
    }
}
