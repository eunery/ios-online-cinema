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
    
    var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var type: CoordinatorType { .app }
    weak var finishDelegate: CoordinatorFinishDelegate? = nil
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
    }
    
    func start() {
        showDetailsView()
//        showTabBar()
    }
    
    func showTabBar() {
        let vc = TabBarCoordinator(navigationController)
        childCoordinators.append(vc)
        vc.parentCoordinator = self
        vc.start()
    }
    
    func showDetailsView() {
        let vc = MoviesDetailsCoordinator(navigationController)
        childCoordinators.append(vc)
        vc.parentCoordinator = self
        vc.start()
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter({$0.type != childCoordinator.type})
    }
}
