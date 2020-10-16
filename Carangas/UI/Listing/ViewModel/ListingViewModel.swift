//
//  ListingViewModel.swift
//  Carangas
//
//  Created by Valmir Junior on 15/10/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import Foundation

final class ListingViewModel {
    
    //MARK: - Properties
    private var cars: [Car] = [] {
        didSet {
            carsDidUpdate?()
        }
    }
    private let service = CarAPI()
    var carsDidUpdate: (() -> Void)?
    
    //MARK: - Methods
    var count: Int {
        cars.count
    }
    
    func loadCars() {
        CarAPI().loadCars { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let cars):
                self.cars = cars
            case .failure:
                self.carsDidUpdate?()
            }
        }
    }
    
    private func getCar(at indexPath: IndexPath) -> Car {
        cars[indexPath.row]
    }
    
    func cellViewModel(for indexPath: IndexPath) -> CarCellViewModel {
        CarCellViewModel(car: getCar(at: indexPath))
    }
    
    func deleteCar(at indexPath: IndexPath, onComplete: @escaping ((Result<Void, APIError>) ->  Void)) {
        let car = cars[indexPath.row]
        
        CarAPI().deleteCar(car) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success():
                self.cars.remove(at: indexPath.row)
            case .failure:
                break
            }
            onComplete(result)
        }
    }
    
    func getVisualizationViewModel(for indexPath: IndexPath) -> VisualizationViewModel {
        VisualizationViewModel(car: getCar(at: indexPath))
    }
}
