//
//  MoviesModel.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 01.08.2023.
//

import Foundation

struct TrendMoviesResponseModel: Codable {
    let page: Int
    let results: [MovieShortModel]
    let totalPages: Int
    let totalResults: Int
    
    enum codingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct MovieShortModel: Codable {
    let adult: Bool
    let backdropPath: String
    let id: Int
    let title: String
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let posterPath: String
    let mediaType: String
    let genreIds: [Int]
    let popularity: Double
    let releaseDate: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    enum codingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id
        case title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIds = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

struct TrendMoviesViewControllerModel: Codable {
    var page: Int
    var results: [MovieShortViewControllerModel]
    var totalPages: Int
    var totalResults: Int
    
    enum codingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct MovieShortViewControllerModel: Codable {
    var adult: Bool
    var backdropPath: String
    var id: Int
    var title: String
    var originalLanguage: String
    var originalTitle: String
    var overview: String
    var posterPath: String
    var mediaType: String
    var genreStrings: [String]
    var popularity: Double
    var releaseDate: String
    var video: Bool
    var voteAverage: Double
    var voteCount: Int
    
    enum codingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id
        case title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreStrings
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
