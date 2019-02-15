//
//  RatesModel.swift
//  Currencies
//
//  Created by tstepanov on 04/02/2019.
//  Copyright © 2019 persTim. All rights reserved.
//

import Foundation


class RatesModel:RatesModelProtocol, RatesLoaderDelegate {
    
    private var objectsPool = [Rate]()
    
    var ratesLoader:RatesLoaderProtocol! {
        didSet {
            ratesLoader.delegate = self
        }
    }
    
    var dataSource:DataSourceProtocol?
    
    //MARK: - RatesModelProtocol
   
    func loadRates() {
        ratesLoader.loadRates()
    }
    
    //MARK: - RatesLoaderDelegate
    
    func loader(_ loader: RatesLoaderProtocol, didLoadRates rates:[Rate]) {
        var moreRates = rates
        moreRates.append(baseRate)
        dataSource?.items = moreRates
    }
    
    private let baseRate = Rate(currency: Currency.euro, coefficient: 1.0, relatedCurrency: Currency.euro)
    
}
