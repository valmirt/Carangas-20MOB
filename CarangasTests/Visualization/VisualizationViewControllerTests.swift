//
//  VisualizationViewControllerTests.swift
//  CarangasTests
//
//  Created by Valmir Junior on 22/10/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import XCTest
@testable import Carangas

class VisualizationViewControllerTests: XCTestCase {

    var sut: VisualizationViewController!
    var car: Car = {
        var car = Car()
        car.name = "Civic"
        car.brand = "Honda"
        car.price = 25000
        car.gasType = 0
        
        return car
    }()
    
    override func setUp() {
        super.setUp()
        sut = VisualizationViewController.instatiate(from: .visualization)
        
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testVisualizationOfCar() {
        //Given
        sut.viewModel = VisualizationViewModel(car: car)
        sut.loadView()
        
        //When
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        
        //Then
        XCTAssertEqual(sut.title!, "Civic", "Titulo da controller errado")
        XCTAssertEqual(sut.lbBrand.text!, "Marca: Honda")
        XCTAssertEqual(sut.lbPrice.text!, "Preço: R$ 25.000,00")
    }

}
