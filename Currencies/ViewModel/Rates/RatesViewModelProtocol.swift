//
//  RatesViewModelProtocol.swift
//  Currencies
//
//  Created by tstepanov on 04/02/2019.
//  Copyright © 2019 persTim. All rights reserved.
//

import Foundation

protocol RatesViewModelProtocol: CollectionViewModelProtocol {
    
    var title:String? { get }
    
    func didChangeRate(at indexPath:IndexPath, with moneyAmount:Double)
    
    var selectedIndexPaths:[IndexPath] { get }
    
}
