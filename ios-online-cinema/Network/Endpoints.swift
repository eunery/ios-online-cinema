//
//  Endpoints.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 10.08.2023.
//

import Foundation

enum Endpoints: String {
    case trendMovies = "/3/trending/movie/day"
    case moviesDetails = "/3/movie/"
    case moviesGenres = "/3/genre/movie/list"
    case moviesGenerator = "/3/discover/movie"
    case image = "/t/p/w500/"
}
