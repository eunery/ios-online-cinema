//
//  Endpoints.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 10.08.2023.
//

import Foundation

enum Endpoints: String {
    case trendMoviesEndpoint = "/3/trending/movie/day"
    case movieDetailsEndpoint = "/3/movie/"
    case moviesGenres = "/3/genre/movie/list"
}
