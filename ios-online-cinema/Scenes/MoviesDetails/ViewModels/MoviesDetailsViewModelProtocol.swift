//
//  MoviesDetailsViewModelProtocol.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 10.08.2023.
//

import Foundation

protocol MoviesDetailsViewModelProtocol {
    var isLoading: Bool {get set}
    var movie: MoviesDetailsModel? {get set}
    
    func fetch(movieId: Int, completionHandler: @escaping () -> Void)
}
