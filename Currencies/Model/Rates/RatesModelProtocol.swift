//
//  RatesModelProtocol.swift
//  Currencies
//
//  Created by tstepanov on 04/02/2019.
//  Copyright © 2019 persTim. All rights reserved.
//

import Foundation

protocol ModelDelegate {
    
}

protocol RatesModelProtocol {
    
    var baseRate:Rate { get }
    
    var dataSource:DataSourceProtocol? { get set }
    
    func loadRates()
    
}
