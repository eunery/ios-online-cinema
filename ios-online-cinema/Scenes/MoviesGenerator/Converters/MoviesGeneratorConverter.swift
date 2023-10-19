//
//  MoviesGeneratorConverter.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 19.10.2023.
//

import Foundation

class MoviesGeneratorConverter {
    func fromResponseToGenresNames(response: MovieGenresResponseModel) -> [String] {
        var genresNames: [String] = [String]()
        for item in response.genres {
            genresNames.append(item.name)
        }
        return genresNames
    }
}
