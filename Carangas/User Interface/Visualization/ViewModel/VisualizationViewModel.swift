//
//  VisualizationViewModel.swift
//  Carangas
//
//  Created by Valmir Junior on 15/10/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import Foundation

final class VisualizationViewModel {
    private var car: Car
    
    init(car: Car) {
        self.car = car
    }
    
    var title: String {
        car.name
    }
    
    var brand: String {
        "Marca: \(car.brand)"
    }
    
    var fuelType: String {
        "Combustível: \(car.fuel)"
    }
    
    var price: String {
        let price = Formatter.currencyFormatter.string(from: NSNumber(value: car.price)) ?? "R$ \(car.price)"
        return "Preço: \(price)"
    }
    
    func getFormViewModel() -> FormViewModel {
        FormViewModel(car: car)
    }
}
