//
//  RatesListDTO.swift
//  Currencies
//
//  Created by tstepanov on 04/02/2019.
//  Copyright © 2019 persTim. All rights reserved.
//

import Foundation

struct RatesListDTO: Codable {
    
    var base: String
    var date: Date
    var rates: [String: Double]
    
    private enum CodingKeys: String, CodingKey {
        case base
        case date
        case rates
    }
    
}
