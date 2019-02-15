//
//  RateChangingProtocol.swift
//  Currencies
//
//  Created by tstepanov on 15/02/2019.
//  Copyright © 2019 persTim. All rights reserved.
//

import Foundation

@objc protocol RateChangingProtocol: NSObjectProtocol {
    
    func didChange(rate: Any, with amount:Double)
    
}
