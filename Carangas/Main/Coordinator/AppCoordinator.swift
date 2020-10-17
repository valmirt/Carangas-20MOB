//
//  AppCoordinator.swift
//  Carangas
//
//  Created by Valmir Junior on 17/10/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    init() {
        navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.tintColor = UIColor(named: "main")
    }
    
    func start() {
        let coordinator = ListingCoordinator(navigationController: navigationController)
        coordinator.parentCoordinator = self
        add(childCoordinator: coordinator)
        coordinator.start()
    }
}
