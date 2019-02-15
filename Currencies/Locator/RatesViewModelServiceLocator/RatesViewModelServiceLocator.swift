//
//  RatesViewModelServiceLocator.swift
//  Currencies
//
//  Created by tstepanov on 12/02/2019.
//  Copyright © 2019 persTim. All rights reserved.
//

import Foundation

class RatesViewModelServiceLocator {
    
    static func ratesViewModel() -> RatesViewModelProtocol {
        let ratesViewModel = RatesViewModel()
        ratesViewModel.model = ratesModel()
        return ratesViewModel
    }
    
    static private func ratesModel() -> RatesModelProtocol {
        
        let ratesModel = RatesModel()
        ratesModel.ratesLoader = ratesLoader()
        ratesModel.dataSource = DataSource<Rate>() as DataSourceProtocol
        return ratesModel
    
    }
    
    static private func ratesLoader() -> RatesLoaderProtocol {
        return RatesLoaderServiceLocator.ratesLoaderService()
    }
    
}
