//
//  MoviesFeedCoordinator.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 03.08.2023.
//

import Foundation
import UIKit

protocol MoviesFeedProtocol: Coordinator {
    
    func showMoviesDetails()
}

class MoviesFeedCoordinator: Coordinator, MoviesFeedProtocol {
    
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
    
    func showMoviesDetails() {
        let viewController = MoviesDetailsViewController(viewModel: MoviesDetailsViewModel())
        navigationController.setViewControllers([viewController], animated: true)
    }
}
