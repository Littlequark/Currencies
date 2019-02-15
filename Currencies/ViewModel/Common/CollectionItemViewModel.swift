//
//  CollectionItemViewModel.swift
//  Currencies
//
//  Created by tstepanov on 13/02/2019.
//  Copyright © 2019 persTim. All rights reserved.
//

import Foundation

class CollectionItemViewModel: DataInitializable, CollectionItemProtocol {
    
    static var itemIdentifier:String {
        return String(describing: type(of: self))
    }
    
    func identify() -> String {
        return CollectionItemViewModel.itemIdentifier
    }
    
    var _dataItem:Any?
    
    required init(with dataItem:Any) {
        _dataItem = dataItem
    }
    
}
