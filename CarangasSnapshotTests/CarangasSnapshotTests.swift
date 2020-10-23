//
//  CarangasSnapshotTests.swift
//  CarangasSnapshotTests
//
//  Created by Valmir Junior on 22/10/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import XCTest
import FBSnapshotTestCase
@testable import Carangas

class CarangasSnapshotTests: FBSnapshotTestCase {
    
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
        
        recordMode = false
        fileNameOptions = [.device, .screenSize, .OS]
        usesDrawViewHierarchyInRect = true
        
        sut = VisualizationViewController.instatiate(from: .visualization)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testView() {
        //Given
        sut.viewModel = VisualizationViewModel(car: car)
        
        //When
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        
        //Then
        FBSnapshotVerifyView(sut.view)
    }
}
