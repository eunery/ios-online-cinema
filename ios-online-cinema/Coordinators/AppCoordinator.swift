//
//  AppCoordinator.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 01.08.2023.
//

import UIKit

class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navVC: UINavigationController) {
        self.navigationController = navVC
    }
    
    func start() {
        print("AppCordinator starts!")
        var vc: UIViewController & Coordinating = MoviesFeedVC()
        vc.coordinator = self
        navigationController.setViewControllers([vc], animated: false)
    }
    
    func goToMoviesFeed() {
        print("Going to movies feed!")
    }
    
    func goToMoviesDetails() {
        print("Going to movies details!")
        
    }
    
    func goToFavouriteMovies() {
        print("Going to favourite movies!")
    }
}
