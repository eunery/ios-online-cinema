//
//  TabBarCoordinator.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 03.08.2023.
//

import UIKit
import Foundation

protocol TabBarProtocol: Coordinator {
    
    var tabBarController: UITabBarController {get set}
    
    func selectPage(_ page: TabBarPage)
    
    func selectedIndex(_ index: Int)
    
    func currentPage() -> TabBarPage?
}

class TabBarCoordinator: NSObject, TabBarProtocol, Coordinator {
    
    var tabBarController: UITabBarController = TabBarViewController()
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .tabbar }
    
    var parentCoordinator: Coordinator?
    
    var navigationController: UINavigationController
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
//        self.tabBarController = .init()
    }
    
    
    
    func start() {
        print("TabBarCoordinator starts!")
        
        let pages: [TabBarPage] = [.moviesFeed, .favouriteMovies]
            .sorted(by: {$0.pageOrderNumber() < $1.pageOrderNumber() })
        
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        
        prepareTabBarController(withTabBarControllers: controllers)
    }
    
    deinit {
        print("TabBarCoordinator deinit")
    }
    
    func prepareTabBarController(withTabBarControllers tabControllers: [UIViewController]) {
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarPage.moviesFeed.pageOrderNumber()
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.backgroundColor = .white
        
        navigationController.viewControllers = [tabBarController]
        
    }
    
    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: true)
        navController.tabBarItem = UITabBarItem(title: page.pageTitleValue(), image: resizeImage(image: page.pageIcon(), targetSize: CGSize(width: 25, height: 25)), tag: page.pageOrderNumber())
        
        switch page {
        case .moviesFeed:
            let moviesFeedVC = MoviesFeedCoordinator(navController)
            moviesFeedVC.parentCoordinator = self
            moviesFeedVC.start()
        case .favouriteMovies:
            let favouriteMovies = FavouriteMoviesCoordinator(navController)
            favouriteMovies.parentCoordinator = self
            favouriteMovies.start()
        }
        return navController
    }
    
    
    
    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    
    func selectedIndex(_ index: Int) {
        guard let page = TabBarPage.init(index: index) else {return}
        
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    
    func currentPage() -> TabBarPage? {
        TabBarPage.init(index: tabBarController.selectedIndex)
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
