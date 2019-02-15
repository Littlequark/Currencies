//
//  CollectionViewModelProtocol.swift
//  Currencies
//
//  Created by tstepanov on 04/02/2019.
//  Copyright © 2019 persTim. All rights reserved.
//

import Foundation

protocol CollectionItemProtocol: class {
    
    static var itemIdentifier:String { get }
    
    func identify() -> String
    
}

protocol CollectionViewModelProtocol {
    
    var delegate: CollectionViewModelDelegate? { get set }
    
    func numberOfSections() -> Int
    
    func numberOfItemsInsection(_ section: Int) -> Int
    
    func item(at indexPath: IndexPath) -> CollectionItemProtocol?
    
    func titleForSection(_ section: Int) -> String?

    func loadData()
    
}
