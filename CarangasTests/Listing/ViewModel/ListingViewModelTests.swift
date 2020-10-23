//
//  ListingViewModelTests.swift
//  CarangasTests
//
//  Created by Valmir Junior on 22/10/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import XCTest
@testable import Carangas

class ListingViewModelTests: XCTestCase {

    //System Under Test
    var sut: ListingViewModel!
    
    override func setUp() {
        super.setUp()
        sut = ListingViewModel(service: CarAPIStub())
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testCount() {
        //Given
        let expected = 8
        
        //When
        sut.loadCars()
        
        //Then
        XCTAssertEqual(sut.count, expected,  "Total de carros diferente do esperado")
    }
    
    func testFirstCarInfo() {
        //Given
        let indexPath = IndexPath(row: 0, section: 0)
        
        //When
        sut.loadCars()
        let visualizationViewModel = sut.getVisualizationViewModel(for: indexPath)
        
        //Then
        XCTAssertEqual(visualizationViewModel.title, "M3", "Nome do carro errado")
        XCTAssertEqual(visualizationViewModel.brand, "Marca: Acura", "Marca errada")
    }
    
}
