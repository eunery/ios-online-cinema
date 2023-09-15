//
//  TabBarCoordinator.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 03.08.2023.
//

import UIKit
import Foundation

protocol TabBarProtocol: Coordinator {
    
    var tabBarController: UITabBarController { get set }
    
    func selectPage(_ page: TabBarPage)
    func selectedIndex(_ index: Int)
    func currentPage() -> TabBarPage?
}

class TabBarCoordinator: NSObject, TabBarProtocol, Coordinator {
    
    // MARK: - Properties
    
    var tabBarController: UITabBarController = TabBarViewController()
    weak var finishDelegate: CoordinatorFinishDelegate?
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .tabbar }
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    // MARK: - Init
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Private methods
    
    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: true)
        navController.tabBarItem = UITabBarItem(
            title: page.pageTitleValue(),
            image: page.pageIcon(),
            tag: page.pageOrderNumber()
        )
        
        switch page {
        case .moviesFeed:
            let moviesFeedVC = MoviesFeedCoordinator(navController)
            moviesFeedVC.parentCoordinator = self
            moviesFeedVC.start()
        case .moviesGenerator:
            let moviesGenerator = MoviesGeneratorCoordinator(navController)
            moviesGenerator.parentCoordinator = self
            moviesGenerator.start()
        case .favouriteMovies:
            let favouriteMovies = FavouriteMoviesCoordinator(navController)
            favouriteMovies.parentCoordinator = self
            favouriteMovies.start()
        }
        return navController
    }
    
    // MARK: - Methods
    
    func start() {
        let pages: [TabBarPage] = [.moviesFeed, .moviesGenerator, .favouriteMovies]
            .sorted(by: {$0.pageOrderNumber() < $1.pageOrderNumber() })
        
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        
        prepareTabBarController(withTabBarControllers: controllers)
    }
    
    func prepareTabBarController(withTabBarControllers tabControllers: [UIViewController]) {
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarPage.moviesGenerator.pageOrderNumber()
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.backgroundColor = .white
        
        navigationController.viewControllers = [tabBarController]
    }
    
    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    
    func selectedIndex(_ index: Int) {
        guard let page = TabBarPage(index: index) else {return}
        
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    
    func currentPage() -> TabBarPage? {
        TabBarPage(index: tabBarController.selectedIndex)
    }
}
