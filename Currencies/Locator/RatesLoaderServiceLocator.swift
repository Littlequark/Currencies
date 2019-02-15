//
//  RatesLoaderServiceLocator.swift
//  Currencies
//
//  Created by tstepanov on 12/02/2019.
//  Copyright © 2019 persTim. All rights reserved.
//

import Foundation

class RatesLoaderServiceLocator {
    
    static func ratesLoaderService() -> RatesLoaderProtocol {
        let ratesLoader = RatesLoader()
        ratesLoader.networkClient = networkClient()
        return ratesLoader
    }
    
    static private func networkClient() -> NetworkClientProtocol {
        let networkClient = NetworkClient()
        return networkClient
    }
    
}
