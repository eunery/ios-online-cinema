//
//  MoviesDetailsCoordinator.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 15.08.2023.
//

import Foundation
import UIKit

protocol MoviesDetailsProtocol: Coordinator {
    
}

class MoviesDetailsCoordinator: Coordinator, MoviesDetailsProtocol {
    var finishDelegate: CoordinatorFinishDelegate?
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType {.moviesDetails}
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    init(_ navVC: UINavigationController) {
        self.navigationController = navVC
    }
    
    func start() {
        let vc = MoviesDetailsViewController(viewModel: MoviesDetailsViewModel())
        vc.coordinator = self
        navigationController.setViewControllers([vc], animated: true)
    }
}
