//
//  MovieGenresResponseModel.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 07.08.2023.
//

import Foundation

struct MovieGenresResponseModel: Codable {
    let genres: [GenreModel]
}

struct GenreModel: Codable {
    let id: Int
    let name: String
}
