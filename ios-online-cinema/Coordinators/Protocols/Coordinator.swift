//
//  Coordinator.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 01.08.2023.
//

import UIKit

protocol Coordinator: AnyObject {
    
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    
    var parentCoordinator: Coordinator? { get set }
    
    var childCoordinators: [Coordinator] { get set }
    
    var navigationController: UINavigationController { get set}
    
    var type: CoordinatorType { get }
    
    func start()
    
    func finish()
}

extension Coordinator {
    func finish() {
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}

enum CoordinatorType {
    case app, tabbar, moviesFeed, favouriteMovies
}
