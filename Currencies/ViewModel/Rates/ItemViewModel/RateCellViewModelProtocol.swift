//
//  RateCellViewModelProtocol.swift
//  Currencies
//
//  Created by tstepanov on 15/02/2019.
//  Copyright © 2019 persTim. All rights reserved.
//

import Foundation

protocol RateCellViewModelProtocol:DataInitializable {
    
    var currencyIdentifier: String? { get }
    
    var rate:String?  { get }
    
}
