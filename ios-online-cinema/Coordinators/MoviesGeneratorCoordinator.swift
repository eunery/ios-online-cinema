//
//  MoviesGeneratorCoordinator.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 08.09.2023.
//

import Foundation
import UIKit

protocol MoviesGeneratorCoordinatorProtocol: Coordinator {
    func showMoviesDetails(movieId: Int)
}

class MoviesGeneratorCoordinator: Coordinator, MoviesGeneratorCoordinatorProtocol {
    
    // MARK: - Properties
    
    var finishDelegate: CoordinatorFinishDelegate?
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var type: CoordinatorType { .moviesGenerator }
    
    // MARK: - Init
    
    init(_ navVC: UINavigationController) {
        self.navigationController = navVC
    }
    
    // MARK: - Methods
    
    func start() {
        let viewController = MoviesGeneratorViewController(viewModel: MoviesGeneratorViewModel())
        viewController.coordinator = self
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func showMoviesDetails(movieId: Int) {
        let viewController = MoviesDetailsViewController(viewModel: MoviesDetailsViewModel(movieId: movieId))
        navigationController.pushViewController(viewController, animated: true)
    }
}
