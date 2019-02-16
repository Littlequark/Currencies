//
//  RatesLoaderProtocol.swift
//  Currencies
//
//  Created by tstepanov on 31/01/2019.
//  Copyright © 2019 persTim. All rights reserved.
//

import Foundation

protocol RatesLoaderDelegate: class {
    
    func loader(_ loader:RatesLoaderProtocol, didLoadRates rates:[Rate])
    
    func loader(_ loader:RatesLoaderProtocol, didReceiveError error:Error)
    
}

protocol RatesLoaderProtocol {
    
    var delegate: RatesLoaderDelegate? {get set}
    
    func loadRates()
    
}
