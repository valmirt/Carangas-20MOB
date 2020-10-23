//
//  CarAPIStub.swift
//  CarangasTests
//
//  Created by Valmir Junior on 22/10/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import Foundation
@testable import Carangas

class CarAPIStub: CarAPIProtocol {
    
    func loadCars(onComplete: @escaping (Result<[Car], APIError>) -> Void) {
        let bundle = Bundle(for: CarAPIStub.self)
        let url = bundle.url(forResource: "CarsMocked", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let cars = try! JSONDecoder().decode([Car].self, from: data)
        onComplete(.success(cars))
    }
    
    func deleteCar(_ car: Car, onComplete: @escaping (Result<Void, APIError>) -> Void) {
        onComplete(.success(()))
    }
}
