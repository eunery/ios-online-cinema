//
//  FavouriteMoviesCoordinator.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 03.08.2023.
//

import Foundation
import UIKit

protocol FavouriteMoviesCoordinatorProtocol: Coordinator {
    func showMoviesDetails(movieId: Int)
}

class FavouriteMoviesCoordinator: Coordinator, FavouriteMoviesCoordinatorProtocol {
    
    // MARK: - Properties
    
    var finishDelegate: CoordinatorFinishDelegate?
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .favouriteMovies }
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    // MARK: - Init
    
    init(_ navVC: UINavigationController) {
        self.navigationController = navVC
    }
    
    // MARK: - Methods
    
    func start() {
        let viewController = FavouriteMoviesViewController(viewModel: FavouriteMoviesViewModel())
        viewController.coordinator = self
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func showMoviesDetails(movieId: Int) {
        let viewController = MoviesDetailsViewController(viewModel: MoviesDetailsViewModel(movieId: movieId))
        navigationController.pushViewController(viewController, animated: true)
    }
}
