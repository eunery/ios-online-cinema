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
    var finishDelegate: CoordinatorFinishDelegate?
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType {.moviesFeed}
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    init(_ navVC: UINavigationController) {
        self.navigationController = navVC
    }
    
    func start() {
        print("MoviesFeedCordinator starts!")
        let vc = MoviesFeedViewController()
        vc.coordinator = self
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func showMoviesDetails() {
        let vc = MoviesDetailsViewController()
        navigationController.setViewControllers([vc], animated: true)
    }
}
