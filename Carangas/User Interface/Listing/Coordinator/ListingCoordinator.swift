//
//  ListingCoordinator.swift
//  Carangas
//
//  Created by Valmir Junior on 17/10/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import UIKit

final class ListingCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = ListingTableViewController.instatiate(from: .listing)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func didFinish(child coordinator: Coordinator?) {
        if let coordinator = coordinator {
            remove(childCoordinator: coordinator)
        } else {
            parentCoordinator?.didFinish(child: self)
        }
    }
    
    deinit {
        print("ListingCoordinator já era")
    }
}

extension ListingCoordinator: VisualizationPresenter, FormPresenter {
    func showVisualization(with viewModel: VisualizationViewModel) {
        let coordinator = VisualizationCoordinator(navigationController: navigationController, visualizationViewModel: viewModel)
        coordinator.parentCoordinator = self
        add(childCoordinator: coordinator)
        coordinator.start()
    }
    
    func showForm(with viewModel: FormViewModel) {
        let coordinator = FormCoordinator(navigationController: navigationController)
        coordinator.parentCoordinator = self
        add(childCoordinator: coordinator)
        coordinator.start()
    }
}
