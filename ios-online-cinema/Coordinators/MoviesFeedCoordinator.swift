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
    var finishDelegate: CoordinatorFinishDelegate?
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType {.moviesFeed}
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    init(_ navVC: UINavigationController) {
        self.navigationController = navVC
    }
    
    func start() {
        let vc = MoviesFeedViewController(viewModel: MoviesFeedViewModel())
        vc.coordinator = self
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func showMoviesDetails(movieId: Int) {
        let vc = MoviesDetailsViewController(viewModel: MoviesDetailsViewModel(movieId: movieId))
        navigationController.pushViewController(vc, animated: true)
    }
}
