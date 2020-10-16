//
//  CarCellViewModel.swift
//  Carangas
//
//  Created by Valmir Junior on 15/10/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import Foundation

final class CarCellViewModel: VehicleCellViewModelProtocol {
    private var car: Car
    
    init(car: Car) {
        self.car = car
    }
    
    var name: String {
        car.name
    }
    
    var brand: String {
        car.brand
    }
}
