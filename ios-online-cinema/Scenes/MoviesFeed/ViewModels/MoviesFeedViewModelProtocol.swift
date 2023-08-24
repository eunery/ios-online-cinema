//
//  MoviesFeedViewModelProtocol.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 10.08.2023.
//

import Foundation

protocol MoviesFeedViewModelProtocol {
    
    var dataSource: [MovieCollectionViewCellModel] { get set }
    var currentPage: Int { get set }
    
    func start(completionHandler: @escaping (Result<Void, APIError>) -> Void)
    func fetch(page: Int?, completionHandler: @escaping (Result<Void, APIError>) -> Void)
    func setupDataSource(
        response: TrendMoviesResponseModel,
        completionHandler: @escaping (Result<Void, APIError>) -> Void)
    func validatePage(indexPath: IndexPath) -> Bool
}
