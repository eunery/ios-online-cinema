//
//  AppCoordinator.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 01.08.2023.
//

import UIKit

protocol AppCoordinatorProtocol {
    
    func showTabBar()
}

class AppCoordinator: Coordinator, AppCoordinatorProtocol {
    
    // MARK: - Properties
    
    var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var type: CoordinatorType { .app }
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    // MARK: - Init
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - Methods
    
    func start() {
        showTabBar()
    }
    
    func showTabBar() {
        let coordinator = TabBarCoordinator(navigationController)
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter({$0.type != childCoordinator.type})
    }
}
