//
//  Currency.swift
//  Currencies
//
//  Created by tstepanov on 31/01/2019.
//  Copyright © 2019 persTim. All rights reserved.
//

import Foundation

struct Currency: Equatable {
    
    var identifier: String
    
    static func == (lhs:Currency, rhs:Currency) -> Bool {
        return  lhs.identifier == rhs.identifier
    }
    
    static let euro = Currency(identifier:"EUR")
    
}
