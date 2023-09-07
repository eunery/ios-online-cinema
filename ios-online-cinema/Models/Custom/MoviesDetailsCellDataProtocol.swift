//
//  MoviesDetailsCellData.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 25.08.2023.
//

import Foundation

enum MoviesDetailsCellType {
    case poster
    case info
    case overview
}

protocol MoviesDetailsCellDataProtocol {
    var type: MoviesDetailsCellType { get }
}

struct MoviesDetailsPosterCellData: MoviesDetailsCellDataProtocol {
    var type: MoviesDetailsCellType = .poster
    var poster: String
}

struct MoviesDetailsInfoCellData: MoviesDetailsCellDataProtocol {
    var type: MoviesDetailsCellType = .info
    var genres: String
    var vote: String
    var date: String
    var isFavourite: Bool
}

struct MoviesDetailsOverviewCellData: MoviesDetailsCellDataProtocol {
    var type: MoviesDetailsCellType = .overview
    var title: String
    var overview: String
}
