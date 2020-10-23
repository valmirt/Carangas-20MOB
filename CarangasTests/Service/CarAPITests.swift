//
//  CarAPITests.swift
//  CarangasTests
//
//  Created by Valmir Junior on 22/10/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import XCTest
@testable import Carangas

class CarAPITests: XCTestCase {

    var sut: CarAPI!
    
    override func setUp() {
        super.setUp()
        sut = CarAPI()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testLoadCarsResponseSuccess() {
        //Given
        let promise = expectation(description: "Success!")
        
        //When
        sut.loadCars { (result) in
            defer { promise.fulfill() }
            switch result {
            case .success:
                XCTAssertTrue(true)
            case .failure(let error):
                XCTFail(error.errorMessage)
            }
        }
        
        //Then
        wait(for: [promise], timeout: 3.0)
    }
}
