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
    let total_pages: Int
    let total_results: Int
}

struct MovieShortModel: Codable {
    let adult: Bool
    let backdrop_path: String
    let id: Int
    let title: String
    let original_language: String
    let original_title: String
    let overview: String
    let poster_path: String
    let media_type: String
    let genre_ids: [Int]
    let popularity: Double
    let release_date: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
}
