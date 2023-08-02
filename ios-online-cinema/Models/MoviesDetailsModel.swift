//
//  MoviesDetailsModel.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 01.08.2023.
//

import Foundation

struct MoviesDetailsModel: Codable {
    let adult: Bool
    let backdrop_path: String
    let belongs_to_collection: MovieCollectionModel?
    let budget: Int
    let genres: GenreModel
    let homepage: String
    let id: Int
    let imdb_id: String
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Double
    let poster_path: String
    let production_companies: [ProductionCompaniesModel?]
    let production_countries: [ProductionCountriesModel?]
    let release_date: String
    let revenue: String
    let runtime: Int
    let spoken_languages: [SpokenLanguagesModel]
    let status: String
    let tagline: String
    let title: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
}

struct MovieCollectionModel: Codable {
    let id: Int
    let name: String
    let poster_path: String
    let backdrop_path: String
}

struct GenreModel: Codable {
    let id: Int
    let name: String
}

struct ProductionCompaniesModel: Codable {
    let id: Int
    let logo_path: String?
    let name: String
    let origin_country: String?
}

struct ProductionCountriesModel: Codable {
    let iso_3166_1: String
    let name: String
}

struct SpokenLanguagesModel: Codable {
    let english_name: String
    let iso_639_1: String
    let name: String
}
