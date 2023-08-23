//
//  MoviesDetailsViewModelProtocol.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 10.08.2023.
//

import Foundation

protocol MoviesDetailsViewModelProtocol {
    var movie: MoviesDetailsModel? {get set}
    var movieId: Int {get set}
    var dataSource: MovieDetailsTableViewCellModel? {get set}
    
    func fetch(movieId: Int, completionHandler: @escaping (Result<Void, APIError>) -> Void)
}
