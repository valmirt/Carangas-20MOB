//
//  FormCoordinator.swift
//  Carangas
//
//  Created by Valmir Junior on 17/10/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import UIKit

final class FormCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    let formViewModel: FormViewModel
    
    init(navigationController: UINavigationController, formViewModel: FormViewModel = FormViewModel()) {
        self.navigationController = navigationController
        self.formViewModel = formViewModel
    }
    
    func start() {
        let viewController = FormViewController.instatiate(from: .form)
        viewController.viewModel = formViewModel
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func didFinish(child coordinator: Coordinator?) {
        parentCoordinator?.didFinish(child: self)
    }
    
    deinit {
        print("FormCoordinator já era")
    }
}
