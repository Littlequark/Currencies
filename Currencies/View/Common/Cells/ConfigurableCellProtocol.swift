//
//  ConfigurableCellProtocol.swift
//  Currencies
//
//  Created by tstepanov on 12/02/2019.
//  Copyright © 2019 persTim. All rights reserved.
//

import UIKit

protocol ConfigurableCellProtocol: class {
    
    var viewModel:CollectionItemViewModel? { get set }

}

protocol ReusableCellProtocol: class  {
    
    static var reuseIdentifier:String { get }
    static var cellNib:UINib { get }
    
}
