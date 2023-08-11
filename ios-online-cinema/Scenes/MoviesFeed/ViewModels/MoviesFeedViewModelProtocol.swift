//
//  MoviesFeedViewModelProtocol.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 10.08.2023.
//

import Foundation

protocol MoviesFeedViewModelProtocol {
    var isLoading: Bool {get set}
    var movies: TrendMoviesViewControllerModel? {get set}
    
    func fetch(completionHandler: @escaping () -> Void)
}
