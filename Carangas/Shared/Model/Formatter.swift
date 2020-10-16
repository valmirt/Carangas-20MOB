//
//  Formatter.swift
//  Carangas
//
//  Created by Valmir Junior on 15/10/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import Foundation

struct Formatter {
    static let currencyFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "pt-BR")
        return numberFormatter
    }()
}
