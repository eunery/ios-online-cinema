//
//  MoviesFeedCoordinator.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 03.08.2023.
//

import Foundation
import UIKit

protocol MoviesFeedCoordinatorProtocol: Coordinator {
    func showMoviesDetails(movieId: Int)
}

class MoviesFeedCoordinator: Coordinator, MoviesFeedCoordinatorProtocol {
    
    // MARK: - Properties
    
    var finishDelegate: CoordinatorFinishDelegate?
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType {.moviesFeed}
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    // MARK: - Init
    
    init(_ navVC: UINavigationController) {
        self.navigationController = navVC
    }
    
    // MARK: - Methods
    
    func start() {
        let viewController = MoviesFeedViewController(viewModel: MoviesFeedViewModel())
        viewController.coordinator = self
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    func showMoviesDetails(movieId: Int) {
        let viewController = MoviesDetailsViewController(viewModel: MoviesDetailsViewModel(movieId: movieId))
        navigationController.pushViewController(viewController, animated: true)
    }
}
