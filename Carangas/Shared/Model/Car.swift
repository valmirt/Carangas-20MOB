//
//  Car.swift
//  Carangas
//
//  Created by Valmir Junior on 29/09/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import Foundation

class Car : Codable {
    var _id: String?
    var brand: String = ""
    var name: String = ""
    var price: Int = 0
    var gasType: Int = 0
    
    var fuel: String {
        switch gasType {
        case 0:
            return "Flex"
        case 1:
            return "Alcohol"
        default:
            return "Gasoline"
        }
    }
}
