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
    var dataSource: [MovieCollectionViewCellModel] {get set}
    var page: Int {get set}
    var totalPages: Int {get set}
    
    func fetch(page: Int?, completionHandler: @escaping () -> Void)
    func createCollectionCell()
}
