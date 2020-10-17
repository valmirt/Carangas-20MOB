//
//  Presenter.swift
//  Carangas
//
//  Created by Valmir Junior on 17/10/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import Foundation

protocol VisualizationPresenter: class {
    func showVisualization(with viewModel: VisualizationViewModel)
}

protocol FormPresenter: class {
    func showForm(with viewModel: FormViewModel)
}
