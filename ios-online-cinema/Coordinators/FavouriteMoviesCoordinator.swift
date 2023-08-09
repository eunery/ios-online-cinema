//
//  FavouriteMoviesCoordinator.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 03.08.2023.
//

import Foundation
import UIKit

protocol FavouriteMoviesProtocol: Coordinator {
    
}

class FavouriteMoviesCoordinator: Coordinator, FavouriteMoviesProtocol {
    var finishDelegate: CoordinatorFinishDelegate?
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType {.favouriteMovies}
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(_ navVC: UINavigationController) {
        self.navigationController = navVC
    }
    
    func start() {
        let vc = FavouriteMoviesViewController(viewModel: FavouriteMoviesViewModel())
        vc.coordinator = self
        navigationController.setViewControllers([vc], animated: false)
    }
    
    
}
