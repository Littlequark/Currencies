//
//  Rate.swift
//  Currencies
//
//  Created by tstepanov on 31/01/2019.
//  Copyright © 2019 persTim. All rights reserved.
//

import Foundation

struct Rate: Equatable {
    
    /// 1 item of related currency = (1 item of currency) * coefficient
    var currency: Currency
    var coefficient: Double
    var relatedCurrency: Currency
    
    static func == (lhs:Rate, rhs:Rate) -> Bool {
        return  lhs.currency == rhs.currency &&
                rhs.relatedCurrency == rhs.relatedCurrency
    }
    
    
    
}
