//
//  MoviesFeedViewModel.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 01.08.2023.
//

import Foundation

class MoviesFeedViewModel: MoviesFeedViewModelProtocol {
    var fetchedMovies: TrendMoviesResponseModel? = nil
    var genres: Dictionary<Int,String> = Dictionary<Int, String>()

    func fetch() {
        
    }
}
