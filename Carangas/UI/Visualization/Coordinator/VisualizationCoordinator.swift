//
//  VisualizationCoordinator.swift
//  Carangas
//
//  Created by Valmir Junior on 17/10/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import UIKit

final class VisualizationCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    let visualizationViewModel: VisualizationViewModel
    
    init(navigationController: UINavigationController, visualizationViewModel: VisualizationViewModel) {
        self.navigationController = navigationController
        self.visualizationViewModel = visualizationViewModel
    }
    
    func start() {
        let viewController = VisualizationViewController.instatiate(from: .visualization)
        viewController.viewModel = visualizationViewModel
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func didFinish(child coordinator: Coordinator?) {
        if let coordinator = coordinator {
            remove(childCoordinator: coordinator)
        } else {
            parentCoordinator?.didFinish(child: self)
        }
    }
    
    deinit {
        print("VisualizationCoordinator já era")
    }
}

extension VisualizationCoordinator: FormPresenter {
    func showForm(with viewModel: FormViewModel) {
        let coordinator = FormCoordinator(navigationController: navigationController, formViewModel: viewModel)
        coordinator.parentCoordinator = self
        add(childCoordinator: coordinator)
        coordinator.start()
    }
}
