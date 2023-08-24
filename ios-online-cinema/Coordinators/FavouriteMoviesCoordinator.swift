//
//  FavouriteMoviesCoordinator.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 03.08.2023.
//

import Foundation
import UIKit

protocol FavouriteMoviesCoordinatorProtocol: Coordinator {
    
}

class FavouriteMoviesCoordinator: Coordinator, FavouriteMoviesCoordinatorProtocol {
    var finishDelegate: CoordinatorFinishDelegate?
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType {.favouriteMovies}
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
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
}
