//
//  FormViewModel.swift
//  Carangas
//
//  Created by Valmir Junior on 15/10/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import Foundation

protocol FormViewModelDelegate: class {
    
    func onCar(didCreated: Result<Void, APIError>)
    
    func onCar(didUpdated: Result<Void, APIError>)
    
}

final class FormViewModel {
    
    private var car: Car
    private let service = CarAPI()
    weak var delegate: FormViewModelDelegate?
    
    init(car: Car? = nil) {
        self.car = car ?? Car()
    }
    
    private var isEditing: Bool {
        car._id != nil
    }
    
    var name: String {
        car.name
    }
    
    var brand: String {
        car.brand
    }
    
    var title: String {
        isEditing ? "Update": "Register"
    }
    
    var buttonTitle: String {
        isEditing ? "Update Car" : "Register Car"
    }
    
    var fuelIndex: Int {
        car.gasType
    }
    
    var price: String {
        "\(car.price)"
    }
    
    func saveCar(name: String, brand: String, gasIndex: Int, price: String) {
        car.brand = brand
        car.name = name
        car.gasType = gasIndex
        car.price = Int(price) ?? 0
        
        if isEditing {
            service.updateCar(car) { [weak self] (result) in
                self?.delegate?.onCar(didUpdated: result)
            }
        } else {
            service.createCar(car) { [weak self] (result) in
                self?.delegate?.onCar(didCreated: result)
            }
        }
    }
    
}
